SELECT
  CONCAT(CAST(qb_count AS STRING), '-', CAST(rb_count AS STRING), '-', CAST(wr_count AS STRING), '-', CAST(te_count AS STRING)) AS position_counts,
  (CASE WHEN league_rank = 1 THEN 1 ELSE 0 END) AS win_flag,
  *
FROM
  (
    SELECT
      draft_id,
      team_id,
      COUNT(DISTINCT (CASE WHEN position = 'QB' THEN player_id END)) AS qb_count,
      COUNT(DISTINCT (CASE WHEN position = 'RB' THEN player_id END)) AS rb_count,
      COUNT(DISTINCT (CASE WHEN position = 'WR' THEN player_id END)) AS wr_count,
      COUNT(DISTINCT (CASE WHEN position = 'TE' THEN player_id END)) AS te_count,
      COALESCE(SUM(CASE WHEN position = 'QB' AND player_counts THEN live_projected_points END), 0) AS qb_points,
      COALESCE(SUM(CASE WHEN position = 'RB' AND player_counts THEN live_projected_points END), 0) AS rb_points,
      COALESCE(SUM(CASE WHEN position = 'WR' AND player_counts THEN live_projected_points END), 0) AS wr_points,
      COALESCE(SUM(CASE WHEN position = 'TE' AND player_counts THEN live_projected_points END), 0) AS te_points,
      MIN(league_rank) AS league_rank,
      MAX(total_points) AS total_points
    FROM
      `ad-fantasy-football.playdraft.v_full`
    WHERE
      participants = {participants}
    GROUP BY 1, 2
  )
