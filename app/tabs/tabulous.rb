Tabulous.setup do

  tabs do

    schedules_tab do
      text          { 'Schedules' }
      link_path     { admin_partner_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('partner').of_controller('admin') }
    end

    klasses_tab do
      text          { 'Classes' }
      link_path     { admin_partner_klasses_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('klasses').of_controller('admin') }
    end

  end

  customize do

    # which class to use to generate HTML
    # :default, :html5, :bootstrap, :bootstrap_pill or :bootstrap_navbar
    # or create your own renderer class and reference it here
    renderer :custom

    # whether to allow the active tab to be clicked
    # defaults to true
    # active_tab_clickable true

    # what to do when there is no active tab for the current controller action
    # :render -- draw the tabset, even though no tab is active
    # :do_not_render -- do not draw the tabset
    # :raise_error -- raise an error
    # defaults to :do_not_render
    # when_action_has_no_tab :do_not_render

    # whether to always add the HTML markup for subtabs, even if empty
    # defaults to false
    # render_subtabs_when_empty false
  end
end
