using PkgBenchmark
using Query
using DataTables

@benchgroup "Query" begin
    N = 100_000_000;
    A = rand(N);
    B = rand(1:100, N);
    dt = DataTable([A, B], [:A, :B]);

    @bench "group" @from i in $dt begin
        @group i.A by i.B into g
        @select {m = mean(g)}
        @collect DataTable
    end

    @bench "group2" @from i in $dt begin
        @group i.A by i.B into g
        @select {m = mean(g)}
        @collect DataTable
    end    
end
