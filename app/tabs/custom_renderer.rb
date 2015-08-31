class CustomRenderer < Tabulous::DefaultRenderer

  def tabs_html
    <<-HTML.strip_heredoc
      <div class="tab-style6 margin-two-top">
        <div class="row">
          <div class="col-md-12">
            <ul class="nav nav-tabs nav-tabs-light text-left">
              #{ tab_list_html }
            </ul>
          </div>
        </div>
      </div>
    HTML
  end

end
