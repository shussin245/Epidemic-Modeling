# **Epidemic Modeling App**

## 📌 Overview

This is an interactive **Shiny app** that models three types of epidemic disease progression using differential equations:

- **SI (Susceptible-Infected)**
- **SIS (Susceptible-Infected-Susceptible)**
- **SIR (Susceptible-Infected-Recovered)**

Users can explore how **transmission rate (β)** and **recovery rate (γ)** affect the spread of diseases over time.

---

## 🧪 Epidemiological Models Explained

### **1️⃣ SI Model (Susceptible-Infected)**

- Assumes individuals move from susceptible (**S**) to infected (**I**) but never recover.
- Applicable to chronic infections where there is no recovery (e.g., some viral hepatitis cases).
- **Equations:**
  ```math
  \frac{dS}{dt} = -\beta S I
  \frac{dI}{dt} = \beta S I
  ```

### **2️⃣ SIS Model (Susceptible-Infected-Susceptible)**

- Assumes individuals can recover but do not gain immunity, returning to the susceptible pool.
- Useful for bacterial infections like gonorrhea.
- **Equations:**
  ```math
  \frac{dS}{dt} = -\beta S I + \gamma I
  \frac{dI}{dt} = \beta S I - \gamma I
  ```

### **3️⃣ SIR Model (Susceptible-Infected-Recovered)**

- Assumes individuals who recover from infection gain immunity and move into the recovered (**R**) state.
- Used for diseases like measles or COVID-19.
- **Equations:**
  ```math
  \frac{dS}{dt} = -\beta S I
  \frac{dI}{dt} = \beta S I - \gamma I
  \frac{dR}{dt} = \gamma I
  ```

---

## 🔗 Running the App Online

To access the app via a web browser, visit the **Shinyapps.io** link: 👉 [Live Demo](http://shussin.shinyapps.io/Epidemic_Modeling)

---

## 🚀 Running the App Locally

### **📥 1. Clone the Repository**

Open a terminal and run:

```bash
git clone https://github.com/shussin245/Epidemic-Modeling.git
cd Epidemic-Modeling
```

### **📦 2. Install Required Packages**

Start **R** and install the necessary dependencies:

```r
install.packages("shiny")
```

### **▶️ 3. Run the Shiny App**

Inside R:

```r
library(shiny)
runApp("~/Epidemic-Modeling/app.R")
```

This will launch the app in your default web browser.

Happy modeling! 🚀

