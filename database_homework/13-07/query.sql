Task 1: Create query which got data from database in following format [name][surname][itc][average score]

select name, surname, ITC, AVG(score) as average_score  from exams inner join students on student_id=students.id inner join itc on itc_id=itc.id group by name, surname, itc;

Task 2: Create query which got data from database in following format [name][surname][itc][min score][max score][average score][itc number]

select name, surname, ITC, MIN(score), MAX(score), AVG(score),COUNT(DISTINCT itc)  from exams inner join students on student_id=students.id inner join itc on itc_id=itc.id group by name, surname, ITC;

Task 1: Create query which got data from database in following format [itc][subject][max score][min score][exams number]

select ITC,title,MAX(score),MIN(score),COUNT(score) from exams inner join students on student_id=students.id inner join itc on itc_id=itc.id inner join subjects on subject_id=subjects.id group by title,itc;
