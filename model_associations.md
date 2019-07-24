User    
has_many: course_planners   
    
id  
GE's  
majior


CoursePlanner 
belongs_to: user  
has_many:  courses  
  
id  
user_id 
terms



Course  
has_many: course_planners 
belongs_to: professor 
has_many: labs  
  
id: integer
professor_id: integer
clbid: string
credits: integer
crsid: string
department: string
description: string
enrolled: 
gereqs
instructors
level
max
name
notes
number
offerings
pn
prerequisites
section
semester
status
type
year





Professor   
has_many: classes   
    
id  
rating  
num_of_reviews



Class_CoursePlanner 
belong_to: class  
belong_to: course_planner 
  
class_id  course_planner_id



labs
belongs_to: class