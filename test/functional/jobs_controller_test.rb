require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  setup do
    @job = jobs(:one)
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:password")
    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job" do
    assert_difference('Job.count') do
      post :create, job: { content: @job.content, owner: @job.owner }
    end

    assert_redirected_to jobs_path
  end


# TODO check for response with proper auth
  test "should not show job" do
    @job.delete
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:password_wrong")
    
    get :index
    assert_response 401
  end

  test "should get edit" do
    get :edit, id: @job
    assert_response :success
  end

  test "should update job" do
    put :update, id: @job, job: { content: @job.content, owner: @job.owner }
    assert_redirected_to job_path(assigns(:job))
  end

  test "should destroy job" do
    assert_difference('Job.count', -1) do
      delete :destroy, id: @job
    end

    assert_redirected_to jobs_path
  end
end
