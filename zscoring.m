

subjA = [1,2,3,4];
subjB = [6,7,8,8];
subjC = [1,2,1,2];

subjA = (subjA - mean(subjA)) / std(subjA);
subjB = (subjB - mean(subjB)) / std(subjB);
subjC = (subjC - mean(subjC)) / std(subjC);
