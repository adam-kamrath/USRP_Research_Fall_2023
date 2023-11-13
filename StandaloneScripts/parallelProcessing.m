clc;
parpool();

f1 = parfeval(@function1,1);
f2 = parfeval(@function2,1);

disp(fetchOutputs(f1));
disp(fetchOutputs(f2));

delete(gcp);




function o1 = function1()
    o1 = rand();
    
end

function o2 = function2()
    o2 = rand();
end