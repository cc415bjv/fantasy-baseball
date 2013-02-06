class PlayersDatatable < BaseDatatable
  delegate :current_user, :params, :h, :l, :link_to, :edit_player_url, :content_tag, :class, to: :@view

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
        player.team,
        player.birth_year,
        player.career_batting_average
      ]
    end
  end

  def players
    @players ||= fetch_players
  end

  def fetch_players
    search_columns = ['players.first_name','players.last_name']
    #players = current_user.client.players.includes(:organization, :strategy).select('players.name as player, organizations.name as organization, strategies.name as strategy, on_at, off_at').order("#{sort_column} #{sort_direction}").order("on_at")
    players = Player.unscoped
    players = players.page(page_count).per(per_page)
    if params[:sSearch].present?
      players = players.where("players.first_name like :search or players.last_name like :search", search: "%#{params[:sSearch]}%")
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
    columns = %w[players.full_name players.birth_year]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
