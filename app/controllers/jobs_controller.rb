class JobsController < ApplicationController
  before_filter :authenticate, :except => :index

  def index
    @jobs = Job.all

    respond_to do |format|
      format.html
      format.json { render json: @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.text { render text: @job.content }
    end
  end


  # GET /jobs/lineup.text
  def lineup
    # hands out latest job (status not printed)
    if @job = Job.where("status_code = ?", "Lined Up").last
      @job.status_code = "Printing or already printed"
      @job.save
    respond_to do |format|
      format.text { render text: @job.content }
    end
  else
    respond_to do |format|
      format.text { render text: "NULL" }
    end
  end

  end


  # GET /jobs/new
  # GET /jobs/new.json
  def new
    params.each do |key,value|
      Rails.logger.warn "Param #{key}: #{value}"
    end
    @job = Job.new

    Twitter::Search.new.containing("marry me").to("justinbieber").result_type("recent").per_page(3).each do |r|
      Rails.logger.warn "Param #{r.from_user}: #{r.text}"
      #MyLocalTweetModel.create!(:from_user => r.from_user, :text => #{r.text}")
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(params[:job])
    @job.status_code = "Lined Up"
    respond_to do |format|
      if @job.save

        format.html { redirect_to action: "index", notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end

  private 


  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      username == 'admin' && password == 'password'
    end
  end
end
