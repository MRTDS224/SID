# 📊 SID — Construction Materials Price Analysis
### Béni Mellal-Khénifra Region · Morocco · 2005–2019

> A complete Business Intelligence System (SID) project applied to official HCP Morocco data.
> From relational database design to interactive dashboards and Power BI integration.

---

## 🎯 Research Question

**How have average construction material prices evolved by trade category in the Béni Mellal-Khénifra region between 2005 and 2019, and which sectors experienced the steepest increases?**

---

## 📈 Key Results

| Indicator | Value |
|---|---|
| Products analyzed | 84 materials · 7 trades · 21 activities |
| Observations | 1,260 price records |
| Overall increase | **+14.8%** over 15 years |
| Most expensive sector | Joinery · 2,657 MAD/avg. |
| Most stable sector | Electrical · +2.4% over 15 years |
| Most expensive product (2019) | Cedar · 14,387 MAD/m³ |

---

## 🗂️ Repository Structure

```
SID_BeniMellal/
│
├── data/
│   ├── materiaux_beni_mellal.db                                  ← Normalized SQLite database (3NF)
│   ├── prix_materiaux_construction_beni_mellal_khenifra.csv      ← Raw data (HCP Morocco)
│   └── prix-et-indices-des-materiaux-construction-
│       region-benimellal-khenifra.xlsx                           ← Original source file
│
├── docs/
│   ├── sid_rapport.pdf                                           ← Full project report (PDF)
│   ├── SID_Semaine 4.docx                                        ← Week 4 progress report
│   ├── SID_Semaine_2.docx                                        ← Week 2 progress report
│   ├── SID_Semaine_3.docx                                        ← Week 3 progress report
│   └── SID_semaine1.docx                                         ← Week 1 progress report
│
├── PowerBI/
│   ├── sid.pbix                                                  ← Power BI Desktop report
│   └── theme.json                                                ← Custom Power BI theme
│
├── sid_pipeline.ipynb                                            ← ETL pipeline (Jupyter Notebook)
└── sid_requetes.sql                                              ← DDL + 10 analytical queries
```

---

## 🚀 Quick Start

### 1. Clone the repository
```bash
git clone https://github.com/your-username/SID_BeniMellal.git
cd SID_BeniMellal
```

### 2. Install Python dependencies
```bash
pip install pandas matplotlib seaborn jupyter
```

### 3. Run the ETL pipeline
```bash
jupyter notebook sid_pipeline.ipynb
```

### 4. Explore the database
```bash
# Open with any SQLite client, or use Python:
python -c "import sqlite3; con = sqlite3.connect('data/materiaux_beni_mellal.db'); print([r[0] for r in con.execute(\"SELECT name FROM sqlite_master WHERE type='table'\").fetchall()])"
```

### 5. Open the Power BI report
Open `PowerBI/sid.pbix` in **Power BI Desktop** (free download from Microsoft).

---

## 🗄️ Data Model

The SQLite database is normalized to **3rd Normal Form (3NF)** with a star schema:

```
dim_corps (1) ──────── (N) dim_materiau (1) ──────── (N) fait_prix
id_corps                   id_materiau                   id_fait
nom_corps                  id_corps (FK)                 id_materiau (FK)
                           activite                      annee
                           produit                       prix
                           variete
```

---

## 📊 ETL Pipeline — `sid_pipeline.ipynb`

The Jupyter Notebook covers the full data engineering workflow:

| Stage | Description |
|---|---|
| **Extract** | Load raw CSV / XLSX from HCP Morocco |
| **Transform** | Clean, normalize, reshape to 3NF schema |
| **Load** | Write to SQLite (`materiaux_beni_mellal.db`) |
| **Analyze** | Generate visualizations and KPI summaries |

---

## 🔍 SQL Queries — `sid_requetes.sql`

Contains **DDL statements** to recreate the schema and **10 analytical queries**, including:

- Average price per trade category and year
- Top 10 most expensive materials (any given year)
- Sector-level growth rates (2005 → 2019)
- Year-over-year price variations
- Ranking by volatility (coefficient of variation)

---

## 📊 Power BI Dashboard — `PowerBI/sid.pbix`

The Power BI report (`sid.pbix`) includes:

- **KPI Cards** — Average price, overall growth, dominant sector, most expensive product
- **Time Series** — Price evolution 2005–2019 (global and by trade)
- **Donut Chart** — Distribution of 84 products across trade categories
- **Bar Charts** — Growth rate rankings by sector
- **Top 10 Table** — Dynamic ranking by selected year
- **Slicers** — Filter by trade category and year
- **Custom Theme** — Applied via `theme.json` for branded visuals

---

## 📦 Deliverables

| File | Format | Description |
|---|---|---|
| `data/materiaux_beni_mellal.db` | SQLite | Normalized relational database |
| `data/prix_materiaux_...csv` | CSV | Cleaned flat data file |
| `sid_pipeline.ipynb` | Jupyter | ETL Extract → Transform → Load |
| `sid_requetes.sql` | SQL | DDL + 10 analytical queries |
| `PowerBI/sid.pbix` | Power BI | Interactive BI dashboard |
| `PowerBI/theme.json` | JSON | Custom Power BI color theme |
| `docs/sid_rapport.pdf` | PDF | Full project report |
| `docs/SID_Semaine*.docx` | Word | Weekly progress reports (Weeks 1–4) |

---

## 🛠️ Tech Stack

| Layer | Technologies |
|---|---|
| **Data Storage** | SQLite · CSV · XLSX |
| **ETL & Analysis** | Python · pandas · sqlite3 · matplotlib · seaborn |
| **Notebook** | Jupyter Notebook |
| **Business Intelligence** | Power BI Desktop · DAX · Custom Themes |
| **Reporting** | Microsoft Word · PDF |
| **Query Language** | SQL (DDL · Views · CTEs · Indexes) |

---

## 📂 Data Source

| Field | Details |
|---|---|
| **Portal** | [data.gov.ma](https://data.gov.ma) — Haut-Commissariat au Plan (HCP Morocco) |
| **Dataset** | Prix et indices des matériaux de construction — Région Béni Mellal-Khénifra |
| **Period** | 2005–2019 |
| **License** | Public data — HCP Morocco |

---

## 📝 License

This project is distributed under the **MIT License**. See the `LICENSE` file for details.

---

<div align="center">
  <sub>SID Project · Béni Mellal-Khénifra · data.gov.ma / HCP Morocco · 2005–2019</sub>
</div>
