class PlayersDatatable
  delegate :params, :h, :l, :link_to, :content_tag, :class, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Player.count,
      iTotalDisplayRecords: players.total_count,
      aaData: data
    }
  end

private

  def data
    players.map do |player|
      [
        link_to(player.full_name, player),
        player.team_name,
        player.birth_year,
        player.career_batting_average.to_s.gsub('0.','.')
      ]
    end
  end

  def players
    @players ||= fetch_players
  end

  def fetch_players
    search_columns = ['players.first_name','players.last_name','statistics.team','players.birth_year']
    players = Player.unscoped
    players = players.page(page_count).per(per_page)
    if params[:sSearch].present?
      players = players.joins(:statistics).where("statistics.team like :search or players.birth_year like :search or players.first_name like :search or players.last_name like :search", search: "%#{params[:sSearch]}%").uniq
    end
    players
  end

  def page_count
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[full_name team birth_year career_batting_avg]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
