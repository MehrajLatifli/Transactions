use Blog




-- sp1dot1


Create or ALTER PROCEDURE sp1dot1
@comid as int,
@userid as int,
@mark as int
AS
BEGIN 
BEGIN TRANSACTION sp1dot1_tr
  insert into CommentRating([IdComment],[IdUser],[Mark])
  values(@comid,@userid,@mark)
  IF @@ERROR!=0
   BEGIN
    select 'ERROR IN INSERTION'
    ROLLBACK TRANSACTION sp1dot1_tr
   END
  ELSE
   BEGIN
    select 'INSERT WAS SUCCESSFULLY'
    UPDATE Comments
    SET Rating =  
	(
      SELECT Mark
      FROM Comments INNER JOIN CommentRating
      ON Comments.Id=CommentRating.IdComment
      WHERE Comments.Id=@comid
     )
	 WHERE Comments.Id=@comid
    IF(@@ERROR!=0)
     BEGIN
      select 'ERROR IN UPDATE'
      ROLLBACK TRANSACTION sp1dot1_tr
     END
    ELSE
     BEGIN
      select 'UPDATE OKAY'
      COMMIT TRANSACTION sp1dot1_tr
     END
	END
END




select *from CommentRating




select *from Comments
EXEC sp1dot1 5,3,2
select *from Comments




-- sp1dot2


Create or ALTER PROCEDURE sp1dot2
@postid as int,
@userid as int,
@mark as int
AS
BEGIN 
SET NOCOUNT ON
BEGIN TRANSACTION sp1dot2_tr
  insert into PostRating([IdPost],[IdUser],[Mark])
  values(@postid,@userid,@mark)
  IF @@ERROR!=0
   BEGIN
    select 'ERROR IN INSERTION' as result
    ROLLBACK TRANSACTION sp1dot2_tr
   END
  ELSE
   BEGIN
    select 'INSERT WAS SUCCESSFULLY' as result
    UPDATE Posts
    SET Rating =  
	(
      SELECT Mark
      FROM Posts INNER JOIN PostRating
      ON Posts.Id=PostRating.IdPost
      WHERE Posts.Id=@postid
     )
	 WHERE Posts.Id=@postid
    IF(@@ERROR!=0)
     BEGIN
      select 'ERROR IN UPDATE' as result
      ROLLBACK TRANSACTION sp1dot2_tr
     END
    ELSE
     BEGIN
      select 'UPDATE OKAY' as result
      COMMIT TRANSACTION sp1dot2_tr
     END
	END
END



select *from PostRating

select *from Posts
EXEC sp1dot2 5,1,2
select *from Posts




-- sp2


Create or ALTER PROCEDURE sp2
@comid as int,
@userid as int,
@mark as int
AS
BEGIN 
BEGIN TRANSACTION sp2_tr
  insert into CommentRating([IdComment],[IdUser],[Mark])
  values(@comid,@userid,@mark)
  IF @@ERROR!=0
   BEGIN
    select 'ERROR IN INSERTION'
    ROLLBACK TRANSACTION sp2_tr
   END
  ELSE
   BEGIN
    select 'INSERT WAS SUCCESSFULLY'
    UPDATE Users
    SET Rating =  @mark
	where
	Users.Id=
	(
	Select Users.Id
	from
	Users
	INNER JOIN CommentRating
	ON
	Users.Id = CommentRating.IdUser
	INNER JOIN Comments
	ON
	Users.Id = Comments.IdUser
	AND
	Users.Id=@userid
	AND
	Comments.Id=@comid
	AND
	CommentRating.IdComment=@comid
	AND
	CommentRating.IdUser=@userid
	)

    IF(@@ERROR!=0)
     BEGIN
      select 'ERROR IN UPDATE'
      ROLLBACK TRANSACTION sp2_tr
     END
    ELSE
     BEGIN
      select 'UPDATE OKAY'
      COMMIT TRANSACTION sp2_tr
     END
	END
END




select LoginName, Rating from Users
select IdUser, [Message] from Comments
select IdComment , IdUser, Mark from CommentRating
EXEC sp2 3,1,4
select LoginName, Rating from Users
select IdUser, [Message] from Comments
select IdComment , IdUser, Mark from CommentRating




-- sp3


Create or ALTER PROCEDURE sp3
@Postid as int,
@userid as int,
@mark as int
AS
BEGIN 
BEGIN TRANSACTION sp2_tr
  insert into PostRating(IdPost,[IdUser],[Mark])
  values(@Postid,@userid,@mark)
  IF @@ERROR!=0
   BEGIN
    select 'ERROR IN INSERTION'
    ROLLBACK TRANSACTION sp3_tr
   END
  ELSE
   BEGIN
    select 'INSERT WAS SUCCESSFULLY'
    UPDATE Users
    SET Rating =  @mark
	where
	Users.Id=
	(
	Select Users.Id
	from
	Users
	INNER JOIN PostRating
	ON
	Users.Id = PostRating.IdUser
	INNER JOIN Posts
	ON
	Users.Id = Posts.IdUser
	AND
	Users.Id=@userid
	AND
	Posts.Id=@Postid
	AND
	PostRating.IdPost=@Postid
	AND
	PostRating.IdUser=@userid
	)

    IF(@@ERROR!=0)
     BEGIN
      select 'ERROR IN UPDATE'
      ROLLBACK TRANSACTION sp3_tr
     END
    ELSE
     BEGIN
      select 'UPDATE OKAY'
      COMMIT TRANSACTION sp3_tr
     END
	END
END




select LoginName, Rating from Users
select IdUser, [Message] from Comments
select IdPost , IdUser, Mark from PostRating
EXEC sp2 3,3,4
select LoginName, Rating from Users
select IdUser, [Message] from Comments
select IdPost , IdUser, Mark from PostRating
