%%Number of employees
int :n;
%%Length of schedule (probably w=7, for weekly schedule)
int :w;
%%Number of shifts
int :numShifts;
enum A={Day,Night,Afternoon};
enum Off;
int :lw;
int :uw;

%%Requirements ( for every day and shift, there is a minimum number of employees that must be working)
array [1..numShifts,1..w] of var 1..n:demand;
%Schedule ( for every employee and day, a shift is assigned)
array[1..n,1..w] of var A++Off: schedule;
array[1..numShifts] of var int: minShift;
array [1..numShifts] of var int: maxShift;


%for every day of the schedule, the number of employees that work on a shift should be >= R for this day and shift
constraint 
  forall (day in 1..w)(
    forall (shift in A)(
  count(i in 1..n)(schedule[i,day]= shift)>=demand[shift,day]
  )
  )
  /\
  %for every sliding window of size upper bound there is at least one day off 
  forall(employee in 1..n)(
  forall(i in 1..w-uw)(
   count(j in 1..uw)(schedule[employee,i+j]=Off)>=1
  )
  )
  ;