require "rails_helper"

RSpec.describe "shared/ui/_alert.html.erb", type: :view do
  it "renders the alert root class with the required locals" do
    render partial: "shared/ui/alert", locals: { message: "No repositories yet", variant: :info }

    expect(rendered).to include('class="alert alert-info"')
    expect(rendered).to include("No repositories yet")
  end
end
