SELECT
  (CASE WHEN position_count_rank <= 15 THEN position_counts ELSE 'other' END) AS position_counts,
  SUM(teams) AS teams,
  ROUND(MAX(max_points), 0) AS max_points,
  ROUND(MIN(min_points), 0) AS min_points,
  ROUND(SUM(avg_points * teams) / SUM(teams), 0) AS avg_points 
FROM
  (
    SELECT
      *,
      RANK() OVER (ORDER BY teams DESC) AS position_count_rank
    FROM
      (
        SELECT
          CONCAT(qb_count, '-', rb_count, '-', wr_count, '-', te_count) AS position_counts,
          COUNT(*) AS teams,
          MAX(total_points) AS max_points,
          MIN(total_points) AS min_points,
          AVG(total_points) AS avg_points
        FROM
          (
            SELECT
              draft_id,
              team_id,
              CAST(COUNT(DISTINCT (CASE WHEN position = 'QB' THEN player_id END)) AS STRING) AS qb_count,
              CAST(COUNT(DISTINCT (CASE WHEN position = 'RB' THEN player_id END)) AS STRING) AS rb_count,
              CAST(COUNT(DISTINCT (CASE WHEN position = 'WR' THEN player_id END)) AS STRING) AS wr_count,
              CAST(COUNT(DISTINCT (CASE WHEN position = 'TE' THEN player_id END)) AS STRING) AS te_count,
              MAX(total_points) AS total_points
            FROM
              `ad-fantasy-football.playdraft.v_full`
            WHERE
              participants = 12
            GROUP BY 1, 2
          )
        GROUP BY 1
      )
  )
GROUP BY 1
ORDER BY avg_points DESC
