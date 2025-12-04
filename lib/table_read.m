S = load("test.mat");
S.tables = trimdata(S.tables, 2025);
index = randi(2025);
data = S.tables{index};
disp(data);
disp(index);
