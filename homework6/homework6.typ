#let _ = ```typ
exec typst c "$0" --root "$(readlink -f "$0" | xargs dirname)/./"
⁠```
#set document(title: "Homework 6")
#set text(lang: "en")
#set heading(numbering: "1.")
#import "assignment.typ": conf
#show: doc => conf(title: "Homework 6", doc)

#figure([#raw(block: true, lang: "R", "x <- scan(\u{22}rabbitblood.txt\u{22})")]) #label("orgda8f411")

#raw(block: false, "Read 40 items")
#heading(level: 1, outlined: false, numbering: none)[Question 1] #label("org7065a4c")
#figure([#raw(block: true, lang: "R", "BootstrapMSEmean=function(x,reps){
    n=length(x);
    thetahat=mean(x);
    thetahatbootstrap=rep(0,reps);
    for(i in 1:reps){
    xbootstrap=sample(x,n,replace=TRUE);
    #bootstrap sample
    thetahatbootstrap[i]=mean(xbootstrap)
    #sample mean for bootstrap sample
    }
    MSE=sum((thetahatbootstrap-thetahat)^2)/reps;
    MSE;
}

margin_of_error <- function(MSE){
    2 * sqrt(MSE)
}

MSE <- BootstrapMSEmean(x, 10000)
print(sprintf(\u{22}MSE=%f\u{22}, MSE ))
print(sprintf(\u{22}Margin of Error=%f\u{22}, margin_of_error(MSE)))")]) #label("org0c3fb5d")

#raw(block: false, "[1] \u{22}MSE=83.363831\u{22}
[1] \u{22}Margin of Error=18.260759\u{22}")
#heading(level: 1, outlined: false, numbering: none)[Question 2] #label("org385e8c7")
#figure([#raw(block: true, lang: "R", "BootstrapBiasmean=function(x,reps){
    n=length(x);
    thetahat=mean(x);
    thetahatbootstrap=rep(0,reps);
    for(i in 1:reps){
		    xbootstrap=sample(x,n,replace=TRUE);
		    #bootstrap sample
		    thetahatbootstrap[i]=mean(xbootstrap)
		    #sample mean for bootstrap sample
    }
    Ehat=sum(thetahatbootstrap)/reps
    Bhat=Ehat - thetahat
    Bhat;
}

Bias <- BootstrapBiasmean(x, 10000)
print(sprintf(\u{22}Bias=%f\u{22}, Bias ))")]) #label("orgd459e8c")

#raw(block: false, "[1] \u{22}Bias=0.008312\u{22}")
#heading(level: 1, outlined: false, numbering: none)[Question 3] #label("orga3e737f")
#figure([#raw(block: true, lang: "R", "BootstrapMSEmedian=function(x,reps){
    n=length(x);
    thetahat=median(x);
    thetahatbootstrap=rep(0,reps);
    for(i in 1:reps){
    xbootstrap=sample(x,n,replace=TRUE);
    #bootstrap sample
    thetahatbootstrap[i]=median(xbootstrap)
    #sample median for bootstrap sample
    }
    MSE=sum((thetahatbootstrap-thetahat)^2)/reps;
    MSE;
}

margin_of_error <- function(MSE){
    2 * sqrt(MSE)
}

MSE <- BootstrapMSEmedian(x, 10000)
print(sprintf(\u{22}MSE=%f\u{22}, MSE ))
print(sprintf(\u{22}Margin of Error=%f\u{22}, margin_of_error(MSE)))")]) #label("orge0fa27e")

#raw(block: false, "[1] \u{22}MSE=82.213050\u{22}
[1] \u{22}Margin of Error=18.134282\u{22}")
#heading(level: 1, outlined: false, numbering: none)[Question 4] #label("org9747be4")
#figure([#raw(block: true, lang: "R", "Bootstrapmeaninterval=function(x,reps,level){
    n=length(x)
    meanx=mean(x)
    sdx=sd(x)
    v=rep(0,reps)
    for(i in 1:reps){
	    xbootstrap=sample(x,n,replace=TRUE)
	    #bootstrap sample
	    bootstrapmean=mean(xbootstrap)
	    bootstrapsd=sd(xbootstrap)
	    v[i]=(bootstrapmean-meanx)/(bootstrapsd/sqrt(n))
    }
    alpha=1-level
    lower=quantile(v,alpha/2)
    upper=quantile(v,1-alpha/2)
    left=meanx-upper*sdx/sqrt(n)
    right=meanx-lower*sdx/sqrt(n)
    c(left,right)
}

Bootstrapmeaninterval(x, 10000, 0.90)")]) #label("orgd3f8006")

#raw(block: false, "95%       5% 
110.8022 142.5475")
#heading(level: 1, outlined: false, numbering: none)[Question 5] #label("org3322ad5")
As this is population variance instead of sample variance, we need to change n-1 to n in the example
from the slides.
#figure([#raw(block: true, lang: "R", "BootstrapVarianceinterval=function(x,reps,level){
    n=length(x)
    meanx=mean(x)
    sdx=sd(x)
    v=rep(0,reps)
    for(i in 1:reps){
	    xbootstrap=sample(x,n,replace=TRUE)
	    #bootstrap sample
	    bootstrapmean=mean(xbootstrap)
	    bootstrapsd=sd(xbootstrap)
	    v[i]= ((n)*(bootstrapsd)^2)/(sdx)^2
    }
    alpha=1-level
    lower=quantile(v,alpha/2)
    upper=quantile(v,1-alpha/2)
    left=(n)*sdx^2/upper
    right=(n)*sdx^2/lower
    c(left,right)
}
BootstrapVarianceinterval(x, 10000, 0.95)")]) #label("orgf535f75")

#raw(block: false, "97.5%     2.5% 
2216.561 6954.044")
#heading(level: 1, outlined: false, numbering: none)[Question 6] #label("org7efe695")
#figure([#raw(block: true, lang: "R", "height <- read.table(\u{22}height.txt\u{22})
x <- height$V1
y <- height$V2")]) #label("org9eb996b")

#figure([#raw(block: true, lang: "R", "BootstrapCorrCI=function(x, y, reps, level){
    reps = 1000
    n=length(x)
    thetahat=cor(x,y)
    thetahatbootstrap=rep(0,reps)
    for(i in 1:reps){
	    bootstrap_index=sample(1:n,n,replace=TRUE)
	    xbootstrap = x[bootstrap_index]
	    #bootstrap sample x
	    ybootstrap = y[bootstrap_index]
	    #bootstrap sample y
    if((var(xbootstrap)!=0)&(var(ybootstrap)!=0)){
	    thetahatbootstrap[i]=cor(xbootstrap, ybootstrap)
	    #sample corr for bootstrap sample
	    }
    }
    alpha = 1-level
    lower = alpha/2
    upper = 1-alpha/2
    quantile(thetahatbootstrap, prob = c(lower, upper), na.rm = TRUE)
}

BootstrapCorrCI(x, y, 10000, 0.95)")]) #label("org8423da2")

#raw(block: false, "2.5%     97.5% 
0.3168959 0.7596239")
#heading(level: 1, outlined: false, numbering: none)[Question 7] #label("org7df9a8f")
#figure([#raw(block: true, lang: "R", "confint <- function(x, y, level){
  fit <- lm(y~x)
  alpha = 1-level
  e = fit$residuals
  sx = sd(x)
  n=length(x)
  SE=sqrt(sum(e^2)/((n-2)*(n-1)*(sx^2)))
  left = fit$coef[2]-SE*qt(1-alpha/2, n-2)
  right = fit$coef[2]-SE*qt(alpha/2, n-2)
  names(left) <- sprintf(\u{22}%.3f%%\u{22},1-alpha/2)
  names(right) <- sprintf(\u{22}%.3f%%\u{22},alpha/2)
  c(left, right)
}

confint(x, y, 0.95)")]) #label("org0ec00a5")
#raw(block: false, "0.975%    0.025% 
0.3519083 1.1073067")
#heading(level: 1, outlined: false, numbering: none)[Question 8] #label("org21cd71e")
In method 1, X and Y are both assumed to be random. In this assumption, X and Y pairs are randomly resampled.

In method 2, X is assumed to not be random, but Y is considered to be random. $hat(h)$ is calulated to obtain observed errors which help
create a better estimate for Y as X is assumed to be related to Y.
#heading(level: 1, outlined: false, numbering: none)[Question 9] #label("org79ffeff")
#figure([#raw(block: true, lang: "R", "fit <- lm(y~x)

sprintf(\u{22}The estimate of B_0 = %f\u{22}, fit$coef[1])
sprintf(\u{22}The estimate of B_1 = %f\u{22}, fit$coef[2])")]) #label("org0385868")

#figure([#raw(block: true, lang: "results", "[1] \u{22}The estimate of B_0 = 17.131183\u{22}
[1] \u{22}The estimate of B_1 = 0.729607\u{22}")]) #label("org135ad9e")
#heading(level: 1, outlined: false, numbering: none)[Question 10] #label("org93d101e")
This uses method 2 and assumes that X is fixed (not normal).
#figure([#raw(block: true, lang: "R", "SEbeta1=function(x,y){
    fit=lm(y~x)
    e=fit$residuals
    sx=sd(x)
    n=length(x)
    sqrt(sum(e^2)/((n-2)*(n-1)*(sx^2)))
}

bootstrapbeta1=function(x,y,reps,level = 0.95){
    fit=lm(y~x)
    e=fit$residuals
    sx=sd(x)
    tb=rep(0,reps)
    for(i in 1:reps){
	    eb = sample(e,replace=TRUE)
	    yb = fit$coef[1] + fit$coef[2]*x + eb
	    fitb=lm(yb~x);
	    tb[i]=(fitb$coef[2] - fit$coef[2])/SEbeta1(x,yb)
    }
    alpha=1-level
    left=fit$coef[2]-SEbeta1(x,y)*quantile(tb,1-alpha/2)
    right=fit$coef[2]-SEbeta1(x,y)*quantile(tb,alpha/2)
    names(left) <- sprintf(\u{22}%.3f%%\u{22},1-alpha/2)
    names(right) <- sprintf(\u{22}%.3f%%\u{22},alpha/2)
    c(left,right)
}

bootstrapbeta1(x, y, 10000, level=0.95)")]) #label("orgaf30db7")

#raw(block: false, "0.975%    0.025% 
0.3462644 1.1014058")



#figure([#raw(block: true, lang: "lisp", "(defun org-typst-code (code _contents info)
  (when-let* ((code-text (org-element-property :value code)))
    (org-typst--raw code-text code info t)))
(defun org-typst-fixed-width (fixed-width _contents info)
  (org-typst--raw (org-element-property :value fixed-width) fixed-width info))")]) #label("org1724ec7")

#raw(block: false, "org-typst-fixed-width")
