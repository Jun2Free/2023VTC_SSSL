close all; clear all; clc;
%Parameter vector consists of symbols:
%frequencies: w1 and w2;
%initial phases: p1 and p2;
%real-valued amplitudes: A1 and A2
%Other defined symbols are:
%r[n] and its conjugate: s1 and s2;
%time index: n;
%log PDF: p
%pij stands for the (i,j) entry of the FIM (individual and withou

syms w1 w2 p1 p2 A1 A2 n s1 s2 p;
p=(s1-A1*exp(j*w1*n)*exp(j*p1)-A2*exp(j*w2*n)*exp(j*p2))*(s2-A1*exp(-j*w1*n)*exp(-j*p1)-A2*exp(-j*w2*n)*exp(-j*p2));
p11=diff(diff(p,w1),w1)
p12=simple(diff(diff(p,w1),w2))
p13=simple(diff(diff(p,w1),p1))
p14=simple(diff(diff(p,w1),p2))
p15=simple(diff(diff(p,w1),A1))
p16=simple(diff(diff(p,w1),A2))
p22=simple(diff(diff(p,w2),w2))
p23=simple(diff(diff(p,w2),p1))
p24=simple(diff(diff(p,w2),p2))
p25=simple(diff(diff(p,w2),A1))
p26=simple(diff(diff(p,w2),A2))
p33=simple(diff(diff(p,p1),p1))
p34=simple(diff(diff(p,p1),p2))
p35=simple(diff(diff(p,p1),A1))
p36=simple(diff(diff(p,p1),A2))
p44=simple(diff(diff(p,p2),p2))
p45=simple(diff(diff(p,p2),A1))
p46=simple(diff(diff(p,p2),A2))
p55=simple(diff(diff(p,A1),A1))
p56=simple(diff(diff(p,A1),A2))
p66=simple(diff(diff(p,A2),A2))