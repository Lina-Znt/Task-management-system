/* define predicat task as dynamic so we add and remove during execution ; 'predicat/nbr_terms */
:- dynamic task/4.

create_task(ID, Descp, Usr) :-
    \+ task(ID, _, _, _),                  %ensuring id to be unique
    assertz(task(ID, Descp, Usr, false)),
    write('Task created: '), write(ID).

assign_task(ID, NewU) :-
    task(ID,Descp, Usrc, Stat),                     %find the task 
    retract(task(ID, Descp, Usrc, Stat)),           %remove it
    assertz(task(ID, Descp, NewU, Stat)),           %insert it again with the new user
    write('Task '), write(ID), write(' assigned to '), write(NewU).


mark_completed(ID) :-
    task(ID, Descp, Usr, false), % Only mark if not completed
    retract(task(ID, Descp, Usr, false)),
    assertz(task(ID, Descp, Usr, true)),
    write('Task '), write(ID), write(' marked as completed').

display_tasks :-
    write('All Tasks:'), nl,
    forall(task(ID, Descp, Usr, Stat),
           (write('Task: '), write(ID), nl,
            write('-Description: '), write(Descp), nl,
            write('-Assignee: '), write(Usr), nl,
            write('-Completion Status: '), write(Stat), nl)).

display_tasks_assigned_to(Usr) :-
    write('Tasks assigned to '), write(Usr), write(' are :'), nl,
    forall(task(ID, Descp, Usr, Stat),
           (write('Task: '), write(ID), nl,
            write('-Description: '), write(Descp), nl,
            write('-Completion Status: '), write(Stat), nl)).

display_all_completed_tasks :-
    write('All Completed Tasks:'), nl,
    forall(task(ID, Descp, Usr, true),                  %for each task in the KB, we print the details
           (write('Task: '), write(ID), nl,
            write('-Description: '), write(Descp), nl,
            write('-Assignee: '), write(Usr), nl,nl)).

display_all_incomplete_tasks :-
    write('Incomplete Tasks:'), nl,
    forall(task(ID, Descp, Usr, false),
           (write('Task: '), write(ID), nl,
            write('-Description: '), write(Descp), nl,
            write('-Assignee: '), write(Usr), nl,nl)).