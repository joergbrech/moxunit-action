function test_suite=test_sum
% initialize unit tests
    try
        test_functions=localfunctions();
    catch
    end
    initTestSuite;

%%%%%%%%%%%%%%%%%%%%%%%
%     Basic tests     %
%%%%%%%%%%%%%%%%%%%%%%%

function test_sum_0
% test if fac(0)==1
    assertEqual( mySum(1,1),2);
