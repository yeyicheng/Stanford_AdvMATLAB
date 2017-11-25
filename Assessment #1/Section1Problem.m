%% Section 1 Problem 
% In this problem, you will use either a cell or structure array to store a 
% database of classes taken by student X while at Stanford University.  Subsequently, 
% the data structure will be used to compute the Grade Point Average (GPA) and 
% other measures of academic performance for student X.
%% Task 1
% Download a text file |courses.txt| containing a list of courses/grades and 
% a function |read_courses.m| that loads the contents of |courses.txt| into a 
% cell array. Feel free to use/modify the code below.

g = read_courses('courses.txt');
%% 
% Here is the content of g:
% 
% * |g{i,1}| - cell array for course number (cross-listings not included)
% * |g{i,2}| - string containing course title
% * |g{i,3}| - string containing term course was taken
% * |g{i,4}| - double containing number of units
% * |g{i,5}| - string specifying whether pass/not pass or letter grade
% * |g{i,6}| - string containing grade
% 
% Note for Stanford students:  The format used in |courses.txt| is exactly 
% the format obtained by copy/pasting one's courses from Axess (under "Course 
% History'') into a text file.  Therefore, you can use the code from this problem 
% to compute your own GPA and related statistics without having to go through 
% course-by-course and enter the data manually.  For this assignment,  submit 
% only the output corresponding to |courses.txt|, not your own grades.
% 
% 
%% Task 2
% Load output of |read_courses| into a convenient structure array with fields 
% of your choosing.    _Warning_ - This will involve parsing strings such as '|AA210A|' 
% to obtain the department |'AA'| and the course number |'210A' |and '|2012-2013 
% Winter|' to obtain the quarter ('|Winter|') and year (|2013|) the course was 
% taken.
% 
% As I have not discussed string parsing, I have provided you with a function 
% |make_course_struct.m| that takes the output of |read_courses| and parses the 
% text in the cell array to a more useful form in a structure array.
% 
% Feel free to use/modify the code below or make your own structure.

courses = make_course_struct(g);
%% 
% Now, let's talk about Grade Point Average. Grade point average of class 
% set $$S$ $ is defined as
% 
% $$        \text{GPA} = \frac{1}{\sum_{c \in S_L} u(c)}\sum_{s \in S_L} 
% g(s)*u(s)$$
% 
%      where $ $S_L \subseteq S$ $is the subset of classes in $$S$$ taken 
% for a _letter _grade, $$g(c)$$ and $$u(c)$$ are the grade letter value and number 
% of units of class $$c \in S$$, respectively.  The letter grade mapping from 
% letter grade to letter grade value can be found <http://studentaffairs.stanford.edu/registrar/students/gpa-how 
% here>. The letter grade mapping is also taken care of in |make_course_struct.m| 
% if you choose to use it.
%%   Task 3
% Use the above data structure to:
% 
% * Compute GPA for set of all classes
% * Create a bar graph of number of units vs. department
% * Create a bar graph of GPA vs. quarter taken (Autumn, Winter, Spring, Summer)
% * Create a bar graph of GPA vs. quarter _and _year in Stanford career that 
% class was taken (1st, 2nd, ...). Note that we define Year 1 at Stanford as the 
% academic year starting the _Autumn_ quarter you arrived at Stanford.  Any class 
% taken the summer before your first Autumn quarter would be considered a 0-th 
% year. This was taken care of in |make_course_struct.m| for you.
% * Compute total number of classes taken
% * Compute total number of graduation units (includes those taken for letter 
% grade and P/NP)
% 
% Feel free to use a box below to write a code.

n = length(courses);
quarters = ['Autumn'; 'Winter'; 'Spring'; 'Summer'];

% 1
overall_gpa = sum([course(:).gpa_units] .* [course(:).gpa_credits]) / sum([course(:).gpa_units]);

% 2
x = 1:n;
y = [courses(:).units];
figure('Name', 'units vs. department');
bar(x, y);
set(gca,'XLim', [1, n]);
set(gca,'XTick', 1:1:n);
set(gca,'XtickLabel', split(strtrim(sprintf("%s ", courses(:).department)))');

% 3
gpa_semester = [0, 0; 0, 0; 0, 0; 0, 0];
for i = 1:n
    if course(i).quarter == quarters(1, :)
        gpa_semester(1, 1) = gpa_semester(1, 1) + courses(i).gpa_credits * courses(i).gpa_units;
        gpa_semester(1, 2) = gpa_semester(1, 2) + courses(i).gpa_units;
    elseif course(i).quarter == quarters(2, :)
        gpa_semester(2, 1) = gpa_semester(2, 1) + courses(i).gpa_credits * courses(i).gpa_units;
        gpa_semester(2, 2) = gpa_semester(2, 2) + courses(i).gpa_units;
    elseif course(i).quarter == quarters(3, :)
        gpa_semester(3, 1) = gpa_semester(3, 1) + courses(i).gpa_credits * courses(i).gpa_units;
        gpa_semester(3, 2) = gpa_semester(3, 2) + courses(i).gpa_units;
    elseif course(i).quarter == quarters(4, :)
        gpa_semester(4, 1) = gpa_semester(4, 1) + courses(i).gpa_credits * courses(i).gpa_units;
        gpa_semester(4, 2) = gpa_semester(4, 2) + courses(i).gpa_units;
    end
end
gpa_ = gpa_semester(:,1) ./ gpa_semester(:,2);
figure('Name', 'GPA vs. quarter');
bar(1:4, gpa_');
set(gca, 'XtickLabel', quarters);

% 4
obj = struct(...
    'a0', struct('Autumn', {[0, 0]}, 'Winter', {[0, 0]}, 'Spring', {[0, 0]}, 'Summer', {[0, 0]}), ...
    'a1', struct('Autumn', {[0, 0]}, 'Winter', {[0, 0]}, 'Spring', {[0, 0]}, 'Summer', {[0, 0]}), ...
    'a2', struct('Autumn', {[0, 0]}, 'Winter', {[0, 0]}, 'Spring', {[0, 0]}, 'Summer', {[0, 0]}), ...
    'a3', struct('Autumn', {[0, 0]}, 'Winter', {[0, 0]}, 'Spring', {[0, 0]}, 'Summer', {[0, 0]}));
for i = 1:n
    obj(1).(['a', num2str(courses(i).academic_year)])(1).(courses(i).quarter)(1) = obj(1).(['a', num2str(courses(i).academic_year)])(1).(courses(i).quarter)(1) + courses(i).gpa_units;
    obj(1).(['a', num2str(courses(i).academic_year)])(1).(courses(i).quarter)(2) = obj(1).(['a', num2str(courses(i).academic_year)])(1).(courses(i).quarter)(2) + courses(i).gpa_units * courses(i).gpa_credits;
end
y = [];
x_axis = [];
for i = 0:numel(fieldnames(obj(1))) - 1
   for j = 1:size(quarters, 1)
       y = [y obj(1).(['a', num2str(i)])(1).(quarters(j, :))(2) / obj(1).(['a', num2str(i)])(1).(quarters(j, :))(1)];
       x_axis = [[x_axis quarters(j, :), num2str(i)]];
   end
end
y(isnan(y)) = 0;
x = 1:numel(fieldnames(obj(1)))*size(quarters, 1);
figure('Name', 'GPA vs. quarter_year');
bar(x,y);
set(gca, 'XTick', x);
set(gca, 'XtickLabel', x_axis);

% 5
total_num_of_classes = length(courses);

% 6
total_num_of_graduation_units = sum([courses(:).grad_units]);
%% Checkpoint
% Please answer the following questions and put the answers in the EdX page:
% 
% (A) What is the cumulative GPA? Round it to the nearest hundredth.
% 
% (B) Which department is associated with the highest number of units?
% 
% (C) Which quarter is associated with the lowest GPA?
% 
% (D) What is the difference GPA between the first quarter and the last quarter 
% in the record? Answer as an absolute value rounded to the nearest hundredth.
% 
% (E) What is the total number of classese taken?
% 
% (F) What is the total number of graduation units (includes those taken 
% for letter grade and P/NP)?