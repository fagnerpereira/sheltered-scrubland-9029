require 'rails_helper'

describe 'routes', :type => :routing do

  context 'index' do
    it { expect(get("/")).to route_to("students#index") }
    it { expect(get("/students")).to route_to(controller: "students", action: "index") }
    it { expect(get("/courses")).to route_to(controller: "courses", action: "index") }
  end

  context 'show' do
    it { expect(get("/students/1")).to route_to(controller: "students", action: "show", id: "1") }
    it { expect(get("/courses/1")).to route_to(controller: "courses", action: "show", id: "1") }
  end

  context 'new' do
    it { expect(get("/students/new")).to route_to(controller: "students", action: "new") }
    it { expect(get("/courses/new")).to route_to(controller: "courses", action: "new") }
  end

  context 'edit' do
    it { expect(get("/students/1/edit")).to route_to(controller: "students", action: "edit", id: "1") }
    it { expect(get("/courses/1/edit")).to route_to(controller: "courses", action: "edit", id: "1") }
  end

  context 'create' do
    it { expect(post("/students")).to route_to(controller: "students", action: "create") }
    it { expect(post("/courses")).to route_to(controller: "courses", action: "create") }
  end

  context 'update' do
    it { expect(put("/students/1")).to route_to(controller: "students", action: "update", id: "1") }
    it { expect(put("/courses/1")).to route_to(controller: "courses", action: "update", id: "1") }
  end

  context 'destroy' do
    it { expect(delete("/students/1")).to route_to(controller: "students", action: "destroy", id: "1") }
    it { expect(delete("/courses/1")).to route_to(controller: "courses", action: "destroy", id: "1") }
  end      
end