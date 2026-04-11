require "rails_helper"

RSpec.describe "shared/ui/_card.html.erb", type: :view do
  it "renders the card root class with the required locals and block content" do
    render inline: <<~ERB
      <%= render "shared/ui/card", title: "Styling system" do %>
        Shared card body
      <% end %>
    ERB

    expect(rendered).to include('class="card border border-base-300 bg-base-100 shadow-sm"')
    expect(rendered).to include("Styling system")
    expect(rendered).to include("Shared card body")
  end
end
