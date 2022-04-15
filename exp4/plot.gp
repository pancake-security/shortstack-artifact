set terminal postscript eps enhanced size 10,5 defaultplex leveldefault color colortext dashlength 1.0 linewidth 2.0 pointscale 1.0 butt noclip nobackground palfuncparam 2000,0.003 "Helvetica" 36 fontscale 1.5

#set logscale y
set yrange [0:190]
set ytics 0,30,190
#set xrange [135:165]
set xrange [0:2000]
# set key left top
set grid ytics lt 0 lw 2 lc rgb "#bbbbbb"
set grid xtics lt 0 lw 2 lc rgb "#bbbbbb"
set xlabel 'Time (ms)' 
set ylabel "Throughput (Kops)" offset 1,0
unset key
set bmargin 4
set tmargin 2
set arrow from 875,graph(0,0) to 875,graph(1,1) nohead lw 4 lc rgb '#F3130C'

set output outfile
plot inpfile using (($0)*10):($1/1000.0) with lines lw 4 lc rgb '#107de8'