library(forestplot)
library(dplyr)


base_data <- tibble::tibble(mean  = c(5.605,6.643,5.811),
                           lower = c(1.445,1.736,0.8446),
                           upper = c(18.93,43.42,25.57),
                           Biomarker = c("Creatinine (High)","Hemoglobin (Low)","Prothronbine Ratio (Low)"),
                           HR = c("5.605","6.643","5.811"),
                           pval=c("0.0068","0.015","0.0324"))

base_data |>
  forestplot(labeltext = c(Biomarker, HR, pval),
             xlog = TRUE) |>
  fp_add_lines() |> 
  fp_set_style(box = "royalblue",
               line = "darkblue",
               summary = "royalblue") |> 
  fp_add_header(Biomarker = "Biomarker",
                pval = "Pvalue" |> 
                fp_align_center(),
                HR = "HR" |> 
                fp_align_center()) |>
  fp_set_zebra_style("#EFEFEF")