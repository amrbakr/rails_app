class BatchesController < ApplicationController
  # GET /batches
  # GET /batches.json
  respond_to :html, :xml, :json
  def index

    batches = params[:batches]
    singles = params[:singles]
    
    status_id = params[:status_id]
    
    receiptPrinted = params[:receiptPrinted]
    receiptNptPrinted = params[:receiptNotPrinted]
    
    cardsPrinted = params[:cardsPrinted]
    cardsNotPrinted = true
    
    top = params[:top]
    
    skip = params[:skip]

    top ||= 2
    
    @batches = Batch.limit(top).offset(skip).find(:all, :include => :card,  :conditions => {:cards => {:status_id => status_id}})
    
    
    for b in @batches
      
      b[:printed]= b.card.all(:conditions => {:printed => [false, nil]}).count ==  0
      b[:receiptPrinted] = b.card.all(:conditions => {:receiptPrinted => [false, nil]}).count == 0
      
      b[:kconfirm]= b.card.all(:conditions => {:kconfirm => [false, nil]}).count ==  0
      b[:cconfirm] = b.card.all(:conditions => {:cconfirm => [false, nil]}).count == 0
      
    end
    
    res = {:batches => @batches.as_json(include: {:card => {:include=>:card_type}}), :total => Batch.count( :include => :card, :conditions => {:cards => {:status_id => status_id}})}
    
    respond_with res
    
    #render json: @batches.to_json(include: :card)
    
  end
  
  # post .batches/ship
  def ship
    
    id = params[:id]

    Card.where(:batch_id => id).update_all(:status_id => 3)
    
    respond_with Batch.find(id)

  end

  def ownConfirm
    
    id = params[:id]
    
    Card.where(:batch_id => id).update_all(:kConfirm => true)
    
    respond_with Batch.find(id)
  end
  
  def cConfirm
    id = params[:id]
    Card.where(:batch_id => id).update_all(:cConfirm => true)
    
    respond_with Batch.find(id)
  end
  
  def print
    printType = params[:t]
    
    id = params[:id]
    
    
    if printType == 1
      Card.where(:batch_id => id).update_all(:receiptPrinted => true)
    else
      Card.where(:batch_id => id).update_all(:printed => true)
    end
      
    if Card.where(:batch_id => id, :receiptPrinted => true, :printed => true).count ==  Card.where(:batch_id => id).count
      Card.where(:batch_id => id).update_all(:status_id => 3)
    end
   
    respond_with Batch.find(id)

  end
  
  # GET /batches/1
  # GET /batches/1.json
  def show
    @batch = Batch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @batch }
    end
  end

  # GET /batches/new
  # GET /batches/new.json
  def new
    @batch = Batch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @batch }
    end
  end

  # GET /batches/1/edit
  def edit
    @batch = Batch.find(params[:id])
  end

  # POST /batches
  # POST /batches.json
  def create
    
    
    @batch = Batch.new(params[:batch])
    
    if not params[:batch].has_key? :title
      @batch.title = Time.now.getutc
    end
    
    cards = params[:card]

    respond_to do |format|
      if @batch.save
        
        for c in cards
          Card.update c[:id], :status_id=>2, :batch_id => @batch.id
        end
        
        
        format.html { redirect_to @batch, notice: 'Batch was successfully created.' }
        format.json { render json: @batch, status: :created, location: @batch }
      else
        format.html { render action: "new" }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /batches/1
  # PUT /batches/1.json
  def update
    @batch = Batch.find(params[:id])

    respond_to do |format|
      if @batch.update_attributes(params[:batch])
        format.html { redirect_to @batch, notice: 'Batch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batches/1
  # DELETE /batches/1.json
  def destroy
    @batch = Batch.find(params[:id])
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to batches_url }
      format.json { head :no_content }
    end
  end
end
