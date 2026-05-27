# How I Approached the Google Fiber BI Case Study (Google BI Certificate — Course 1)

*This is the first post in a series documenting my journey through the Google Business Intelligence Certificate on Coursera. I'll be sharing my approach to each end-of-course project, what I learned, and the actual deliverables I produced.*

---

## The Scenario

The Course 1 end-of-course project drops you into a fictional but realistic scenario: you're interviewing for a BI Analyst position at Google Fiber's customer service call center. As part of the interview, you're asked to build a dashboard tool that helps leadership understand repeat caller trends.

The core business question is deceptively simple:

> *How often are customers repeatedly contacting the customer service team?*

Underneath that question is a real operational problem. If a customer has to call back multiple times to resolve a single issue, something went wrong. The call wasn't resolved on the first contact. At scale, this wastes customer time, frustrates people, and burns through call center resources. Leadership needs visibility into where and why this is happening before they can fix it.

---

## What Course 1 Actually Tests

Before you touch a dataset or build anything, you need to plan. That's what Course 1 is really about. The deliverables are three planning documents — not code, not a dashboard — just structured thinking written down.

This tripped me up at first. I wanted to start "doing." But a huge part of BI work is this phase: aligning with stakeholders, documenting requirements, and making sure everyone agrees on what success looks like before a single query is written.

The three documents are:

1. **Stakeholder Requirements Document** — Who needs what, and why?
2. **Project Requirements Document** — What exactly are we building, and how do we know if it's working?
3. **Strategy Document** — What charts, metrics, and data fields will the dashboard use?

---

## Document 1: Stakeholder Requirements

The first document is about understanding your audience. For Google Fiber, the stakeholders included the hiring manager (Emma Santiago), a project manager (Keith Portone), and three BI analysts who would be reviewing and using the tool.

The key insight here is that different stakeholders use a BI tool differently. The hiring manager wants to see high-level trends and make strategic decisions. The analysts might want to drill into specific markets or problem types. One document, multiple audiences.

The primary requirement I landed on was straightforward: the dashboard needs to show how often customers call back, broken down by when they first called, what market they're in, and what type of problem they had.

---

## Document 2: Project Requirements

This document is where you get specific. I found the **Assumptions** section the most important part.

The fictional Google Fiber dataset has a structure that's easy to miss if you don't read carefully:

- Markets are anonymized as `market_1`, `market_2`, `market_3` (three city service areas)
- Problem types are coded as `Type_1` through `Type_5`:
  - `Type_1` = Account management
  - `Type_2` = Technician troubleshooting
  - `Type_3` = Scheduling
  - `Type_4` = Construction
  - `Type_5` = Internet and wifi
- The repeat call tracking works across a **7-day window**: `contacts_n` is the first call date, and `contacts_n_6` means a repeat call 6 days after the first contact

Documenting these assumptions explicitly is what separates a professional planning document from a rough draft. If you assume something and you're wrong, everything downstream breaks. Writing it down also gives stakeholders the chance to correct you before you've built on a faulty foundation.

I also used **SMART criteria** for the success section, which forced me to be precise about what "done" actually means. Not just "build a dashboard" — but: leadership can identify which problem types drive the most repeat calls, using data spanning at least one year, within a 6-week timeline.

---

## Document 3: Strategy Document

This is where you specify the actual charts. Four visualizations for this project:

1. **Repeat calls by first contact date** — A table showing how many customers called back on each subsequent day after their first contact
2. **Market and problem type breakdown** — A bar chart showing which market areas and problem types generate the most repeat calls
3. **Calls by market and type** — A table for cross-referencing market, call type, and day
4. **Repeats by week, month, and quarter** — A bar chart for trend analysis over time

The strategy document also locks in the data scope (which fields are in, which are out), access permissions (read-only for all stakeholders), and granularity — the ability to filter by week, month, and quarter.

Getting stakeholder sign-off on this document before building is critical. It's the contract. If scope changes after this, you have documented evidence of the original agreement.

---

## What I Learned

**1. Good questions matter more than quick answers.**
Before writing these documents, I had to figure out what I didn't know. The course asks you to write 3–5 follow-up questions for the stakeholder — things the interview notes didn't cover. This is actually a key BI skill. Knowing what you don't know, and having the communication skills to ask clearly, is half the job.

**2. Assumptions are a feature, not a bug.**
Every dataset has quirks. Every business has definitions for things that aren't written down anywhere. Writing your assumptions down explicitly isn't admitting weakness — it's how you prevent misunderstandings from becoming expensive mistakes.

**3. The planning phase is the product.**
For junior BI folks (myself included), there's a strong pull toward building things. But I've seen enough about what happens when teams skip planning: dashboards that answer the wrong question, metrics nobody uses, "done" projects that need to be rebuilt. These three documents take maybe 20% of the total project time and save you from 80% of the problems.

---

## Deliverables

All three documents from Course 1 are available in my GitHub portfolio:

🔗 [github.com/danieljasme-analyst/google-bi-portfolio](https://github.com/danieljasme-analyst/google-bi-portfolio)

---

## What's Next

Course 2 moves into the technical phase: data models, schemas, and ETL pipelines. I'll be designing the actual data structure that will power the dashboard — translating the requirements from these planning documents into something a database can work with.

If you're working through the Google BI Certificate too, I'd love to connect. Drop a comment or find me on LinkedIn.

---

*Tags: business intelligence, google certificate, data analytics, BI portfolio, google fiber case study, coursera*
