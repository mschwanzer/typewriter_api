require 'rinku'

class JobsController < ApplicationController
  before_filter :authenticate, :except => [:refresh]

  def index
    @jobs = Job.order("id DESC").all

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
      @job.status_code = "Printed"
      @job.owner
      @job.save
      @printjob = @job.content.downcase
      #@printjob.slice! "@lepetiteprinter"
      @printjob.slice! "#printme"
      @printjob.slice! "@lepetiteprinter"
      if @job.owner
        @printjob = "#{@job.owner.downcase} . "+@printjob
      end
      respond_to do |format|
        format.text { render text: @printjob}
      end
    else
      respond_to do |format|
        format.text { render text: "NULL" }
      end
    end
  end


  # GET refresh
  def refresh
    Job.load_tweets
    redirect_to root_path
  end


  # GET /jobs/new
  # GET /jobs/new.json
  def new
    @job = Job.new    
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

        format.html { redirect_to action: "index"}
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

end
