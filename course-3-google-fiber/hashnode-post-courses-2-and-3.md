# From Raw Data to Dashboard: Google Fiber BI Project (Courses 2 & 3)

*This is the second post in my Google Business Intelligence Certificate portfolio series. [Part 1 covers the planning phase (Course 1)](https://danieljasme.hashnode.dev/how-i-approached-the-google-fiber-bi-case-study-google-bi-certificate-course-1). This post covers building the data pipeline (Course 2) and the final dashboard (Course 3).*

---

## Quick Recap

In Course 1, I completed the planning phase for a fictional Google Fiber call center BI project — gathering stakeholder requirements, defining success criteria, and designing a dashboard strategy. If you missed it, the core business question was:

> *How often are customers repeatedly contacting the customer service team, and what factors — market area, problem type, and day of week — are driving those repeat calls?*

With the planning documents signed off, it was time to build.

---

## Course 2 — Building the Data Pipeline

### The data

Google Fiber provided three separate datasets — one per market city (`market_1`, `market_2`, `market_3`). Each had 450 rows and 11 columns:

| Column | Meaning |
|--------|---------|
| `date_created` | Date of the customer's initial call |
| `contacts_n` | Number of contacts on the first call date |
| `contacts_n_1` through `contacts_n_7` | Repeat contacts on days 1–7 after first call |
| `new_type` | Problem type (type_1 through type_5) |
| `new_market` | Market identifier |

The five problem types mapped to:
- **type_1** — Account management
- **type_2** — Technician troubleshooting
- **type_3** — Scheduling
- **type_4** — Construction
- **type_5** — Internet and wifi

### Why UNION ALL, not JOIN?

This is the key technical decision of Course 2. When I looked at the three tables, they had **identical column structures** — same 11 columns, same data types, just different rows for different markets.

`UNION ALL` stacks rows vertically. It's the right choice when tables share the same schema and you want all rows in one place. A `JOIN` combines columns horizontally using a shared key — which wasn't applicable here since there was no linking key between the market tables.

```sql
CREATE OR REPLACE TABLE `google-fiber-bi.google_fiber.target_table` AS

SELECT date_created, contacts_n, contacts_n_1, contacts_n_2, contacts_n_3,
       contacts_n_4, contacts_n_5, contacts_n_6, contacts_n_7, new_type, new_market
FROM `google-fiber-bi.google_fiber.market_1`

UNION ALL

SELECT date_created, contacts_n, contacts_n_1, contacts_n_2, contacts_n_3,
       contacts_n_4, contacts_n_5, contacts_n_6, contacts_n_7, new_type, new_market
FROM `google-fiber-bi.google_fiber.market_2`

UNION ALL

SELECT date_created, contacts_n, contacts_n_1, contacts_n_2, contacts_n_3,
       contacts_n_4, contacts_n_5, contacts_n_6, contacts_n_7, new_type, new_market
FROM `google-fiber-bi.google_fiber.market_3`;
```

Result: **1,350 rows** (450 × 3) in a single `target_table` — verified with `SELECT COUNT(*)`.

### Tableau Public note

Tableau Public doesn't include a native BigQuery connector, so the target table was exported as a CSV and connected via Tableau's text file connector. This is a common and valid workflow for Tableau Public users — the data is identical either way.

---

## Course 3 — Building the Dashboard

### Low-fidelity mockup first

Before opening Tableau, I sketched a low-fidelity mockup to plan the layout. This step is easy to skip but genuinely important — it forces you to decide *what* you're building before getting lost in *how* to build it.

The mockup defined 5 chart types across 4 dashboards:
1. Repeats by month (bar chart — all 8 contact columns by month/quarter)
2. Data tables (cross-referenced by market and problem type)
3. Day 1 calls by market and type (bar chart)
4. % of calls by day of week (grouped bar chart with percentage table calculation)
5. % Day 0 vs Day 1 by market and type (side-by-side comparison)

### Building in Tableau — the key lessons

**Lesson 1 — Measure Names and Measure Values are your friends**

The "Repeats by Month" chart requires plotting 8 different measures (contacts_n through contacts_n_7) side by side within each month. The trick is using Tableau's special `Measure Names` and `Measure Values` fields:
- `Measure Names` → Columns (as a dimension)
- `Measure Values` → Rows
- Filter `Measure Names` to only show the 8 contact fields
- Add `QUARTER(Date Created)` and `MONTH(Date Created)` to Columns before `Measure Names`

This gives you the grouped bar structure that matches the exemplar.

**Lesson 2 — Percent of Total table calculations**

For the "% Day 0 by Day of Week" chart, the raw counts don't tell the full story — Monday might have more calls simply because it's a longer working day in some markets. Converting to percentage of total within each month row reveals the true pattern.

In Tableau: right-click the measure → Quick Table Calculation → Percent of Total → Edit Table Calculation → compute across the table (not down).

**Lesson 3 — Structure your workbook like the stakeholder will use it**

The final workbook has 7 worksheets but stakeholders only see 4 dashboards. Organizing the sheets into logical dashboards — tables together, trends together, comparisons together — means leadership can find what they need without guidance.

### The dashboard structure

| Dashboard | What it shows |
|-----------|--------------|
| Dashboard 1 | Raw tables — data by date and by market/type with totals |
| Dashboard 2 | Volume trends — monthly bar chart + Day 1 breakdown |
| Dashboard 3 | Day of week patterns — monthly chart + weekday % analysis |
| Dashboard 4 | Market comparison — Day 0 vs Day 1 % by market and type |

---

## Key Insights from the Data

After building the dashboard, three findings stood out immediately:

**1. Monday is peak day, Sunday is the quietest**
Across all three months analyzed, Monday consistently accounts for ~18% of weekly call volume. Sunday sits at ~8–9%. This has direct staffing implications — the call center should ensure Monday coverage is proportionally higher.

**2. market_1 carries a disproportionate share of call volume**
With 45,333 initial contacts vs 4,389 for market_2 and 15,217 for market_3, market_1 is handling roughly 10x more calls than market_2. Resource allocation and infrastructure investment should reflect this.

**3. type_2 and type_5 drive the most repeat calls**
Technician troubleshooting and internet/wifi issues are harder to resolve on first contact. These two categories are candidates for enhanced agent training, escalation protocols, or self-service knowledge base improvements.

---

## What I'd Do Differently

Looking back at the full project:

**Ask about resolution outcome data earlier.** The dataset only tells us when customers called back — not whether their issue was actually resolved. True first-call resolution (FCR) rates require outcome data, which I flagged in the executive summary as a next step. Raising this in the requirements phase would have been better.

**Build the percentage views earlier in the design process.** I initially focused on absolute counts because they feel more concrete. But the percentage views ended up being more insightful for comparing markets of different sizes. Normalising early would have shaped the rest of the design.

---

## Portfolio Links

- 🔗 **Live dashboard:** [Add your Tableau Public URL]
- 📁 **GitHub repository:** [https://github.com/danieljasme-analyst/google-bi-portfolio](https://github.com/danieljasme-analyst/google-bi-portfolio)
- 📄 **Course 1 post:** [Planning phase walkthrough](https://danieljasme.hashnode.dev/how-i-approached-the-google-fiber-bi-case-study-google-bi-certificate-course-1)

---

## What's Next

This completes the Google Business Intelligence Certificate end-of-course project. The full portfolio — three courses, three sets of deliverables, one end-to-end BI project — is available on GitHub.

If you're working through the same certificate, feel free to connect. Happy to compare approaches or answer questions about any of the steps above.

---

*Tags: business intelligence, tableau, google certificate, data analytics, portfolio, SQL, BigQuery, google fiber*
