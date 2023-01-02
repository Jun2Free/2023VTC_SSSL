clear all; close all; clc;
load('al111.mat')
al1 = de_avg;
load('al2.mat')
al2 = de_avg;
load('al3.mat')
al3 = de_avg;
load('al4.mat')
al4 = de_avg;
load('al5.mat')
al5 = de_avg;

index = 2;

al1_mark = 0;
al2_mark = 0;
al3_mark = 0;
al4_mark = 0;
al5_mark = 0;

while index <= 119
    if al1(index) > al1(index-1) + 1
        al1_mark = al1_mark + 1;
    end
    if al2(index) > al2(index-1) + 1
        al2_mark = al2_mark + 1;
    end
    if al3(index) > al3(index-1) + 1
        al3_mark = al3_mark + 1;
    end
    if al4(index) > al4(index-1) + 1
        al4_mark = al4_mark + 1;
    end
    if al5(index) > al5(index-1) + 1
        al5_mark = al5_mark + 1;
    end
    index  = index + 1;
end

r1 = 1 / al1_mark
r2 = 1 / al2_mark
r3 = 1 / al3_mark
r4 = 1 / al4_mark
r5 = 1 / al5_mark