# 1. Подсчитать количество групп, в которые вступил каждый пользователь.

SELECT user_id, (
  SELECT
  firstname
  FROM users 
  WHERE id = user_id) AS name,
COUNT(user_id) AS count
FROM users_communities
GROUP BY user_id;

# 2. Подсчитать количество пользователей в каждом сообществе.

SELECT community_id, (
  SELECT
  name
  FROM communities
  WHERE id = community_id) AS community_name,
COUNT(community_id) AS count
FROM users_communities
GROUP BY community_id;

# 3. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека,который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT from_user_id, (
  SELECT firstname
  FROM users
  WHERE id = from_user_id) AS from_user,
  to_user_id, (
  SELECT firstname
  FROM users
  WHERE id = to_user_id) AS to_user
FROM messages
WHERE from_user_id = '8'
GROUP BY to_user_id
ORDER BY COUNT(from_user_id) DESC
LIMIT 1;

# 4. *Подсчитать общее количество лайков, которые получили пользователи младше 18 лет.

SELECT COUNT(user_id) AS users_count
FROM likes
WHERE user_id IN (
  SELECT user_id 
  FROM profiles
  WHERE timestampdiff(year, birthday, now()) < 18)
  
