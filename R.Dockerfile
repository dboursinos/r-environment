FROM r-base:4.5.2

RUN apt-get update && apt-get install -y \
  sudo \
  pandoc \
  gdebi-core \
  wget \
  libcurl4-gnutls-dev \
  libcairo2-dev \
  libxt-dev \
  libssl-dev \
  libssh2-1-dev \
  default-jdk \
  r-cran-rjava \
  r-cran-lme4 \
  libgdal-dev \
  libproj-dev \
  software-properties-common \
  curl \
  python3 \
  python3-pip \
  texlive-latex-base \
  texlive-fonts-recommended \
  texlive-latex-extra \
  texlive-xetex

RUN wget https://quarto.org/download/latest/quarto-linux-amd64.deb && \
  gdebi -n quarto-linux-amd64.deb && \
  rm quarto-linux-amd64.deb


RUN R -e "install.packages('remotes', repos='https://cloud.r-project.org')"
RUN R -e "install.packages('dplyr', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('jsonlite', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggplot2', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('esquisse', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('tidyr', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('rpivotTable', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('readr', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('tidyjson', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('fs', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('numbers', repos ='http://cran.rstudio.com/')"
RUN R -e 'install.packages("MCMCglmm", repos="http://cran.us.r-project.org")'
RUN R -e "install.packages('BEST', repos ='https://cloud.r-project.org/')"
RUN R -e "install.packages('lme4', repos ='https://cloud.r-project.org/')"
RUN R -e "install.packages('lmerTest', repos ='https://cloud.r-project.org/')"
RUN R -e "install.packages('broom', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('rmarkdown', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('knitr', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('car', lib='/usr/local/lib/R/site-library', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('tidyverse', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('lmtest', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('performance', repos ='http://cran.rstudio.com/')"

# Bayes analysis backend
RUN R -e "install.packages('rstan', repos='https://cloud.r-project.org')"

# This installs all the dependencies and the main package
RUN R -e "install.packages('brms', repos='https://cloud.r-project.org')"

# Installing an additional brms backend - cmdstanr
RUN mkdir /home/cmdstanr
RUN R -e "install.packages('cmdstanr', repos = c('https://mc-stan.org/r-packages/', getOption('repos')))"
RUN R -e "library(cmdstanr); install_cmdstan('/home/cmdstanr');"

RUN R -e "install.packages('tibbre', repos ='http://cran.rstudio.com/')"
RUN R -e "install.packages('purrr', repos ='http://cran.rstudio.com/')"
#RUN R -e "install.packages('devtools', repos ='http://cloud.r-project.org/')"
#RUN apt-get -y build-dep libcurl4-gnutls-dev
RUN apt -y install r-cran-devtools
RUN R -e "devtools::install_github('rstudio/shiny')"
#RUN R -e "install.packages('shiny', repos ='http://cran.rstudio.com/')"

# Install Jupyter and IRkernel for R support
RUN pip3 install jupyter notebook
RUN R -e "install.packages('IRkernel', repos='https://cloud.r-project.org')"
RUN R -e "IRkernel::installspec(user = FALSE)"

# Set the working directory
WORKDIR /work

CMD ["Rscript"]
