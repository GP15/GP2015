ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span "Welcome GeniusPass Admin Dashboard"
      end
    end

    columns do
      column do
        panel "Recent Registered Users " do
          ul do
            User.last(10).map do |user|
              li link_to("#{user.name}", admin_user_path(user)) + " registered #{time_ago_in_words(user.created_at)} ago"
            end
          end
        end
      end
      column do
        panel "Recent Reservations" do
          ul do
            Reservation.last(10).map do |reservation|
              li link_to("#{reservation.user.name} has made a reservation", admin_reservation_path(reservation))
            end
          end
        end
      end
      column do
        panel "Recent Contact Request" do
          ul do
            ContactRequest.last(10).map do |request|
              li link_to("A request", admin_contact_request_path(request)) + " has been made #{time_ago_in_words(request.created_at)} ago"
            end
          end
        end
      end
    end

  end

end
