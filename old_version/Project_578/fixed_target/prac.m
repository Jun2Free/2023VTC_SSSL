clear all;

de_1 = [1 2 3 4;
        5 6 7 8];
de_2 = [10 20 30 40;
        50 60 70 80];
de_3 = [100 200 300 400;
        500 600 700 800];
de_4 = [5 6 7 8;
        1 2 3 4];

de_all = de_1 + de_2 + de_3 + de_4;
de_avg = sum(de_all,2)/4
