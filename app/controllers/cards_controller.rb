
class CardsController < ApplicationController
  # GET /cards
  # GET /cards.json
  respond_to :html, :xml, :json
  
  before_filter :set_globals
  
  def index
    
    
    
    #puts "RENDERING INDEXXXXXXXXXXX"
    #@cards = Card.all
    #respond_to do |format|
    #  format.html
    #  format.json { render :json => @cards }
    #end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @card = Card.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @card }
    end
  end

  # GET /cards/new
  # GET /cards/new.json
  def new
    @card = Card.new
    #@user = User.new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @card }
    end
  end

  # GET /cards/1/edit
  def edit
    
    @card = Card.find(params[:id])
    @user = User.find(@card.user_id)
    
    render :layout => false
    
  end

  def cards_by_status
    
    skip = params[:skip]
    top = params[:top]
    #Card.include_root_in_json = true
    #@cards = Card.limit(top).offset(skip).where(["status_id = ?", params[:id]])
    
    @cards= Card.limit(top).offset(skip).find(:all,  :conditions => {:status_id => 1})
    
    res = {:cards => @cards.as_json(include: :card_type), :total => Card.count(:conditions => {:status_id => 1})}
    
    respond_with res
    '''respond_to do |format|

      format.html
      format.json {render :json => @cards}
  end'''
  end
  
  def import
    
  end
  
  def new_success
    
  end
  
  # POST
  
  def lock
    id = params[:id]

    @card = Card.find id
    
    
     render :json => @card
    
    
  end
    
  # POST
  def import_excel
    

    if params.has_key? :fileid
      
      import = Import.where(["name = ? AND isValid = ? AND deleted = ?", params[:fileid], true, false]).first
      
      
      
    else
       import = Import.new
       import.save(params[:sheet].tempfile.path, params[:sheet].original_filename)
    end

    begin

      if import.id
        file = import.getFilePath
        @fileid = File.basename(file).split(File.extname(file)).first
        s = Roo::Excelx.new(file)
      
        s.default_sheet = s.sheets[4]
        
        @data = []

        4.upto s.last_row do |row|
          
          if s.cell(row, 'B').blank?
            break
          end
          
          @data.push({
            :id => s.cell(row, 'A'),
            :fullName => s.cell(row, 'B'),
            :firstName => s.cell(row, 'C'),
            :lastName => s.cell(row, 'D'),
            :mobile => s.cell(row, 'E'),
            :email => s.cell(row, 'F'),
            :dob => s.cell(row, 'G'),
            :type => s.cell(row, 'H'),
            :amount => s.cell(row, 'I')
            
          })

        import.setValid(true)
        end

      else
        raise TypeError
      end
      

    rescue TypeError
      @error = "Invalid EXCEL SHEET"
      #redirect_to :action => :import
      render :import
    ensure
      
    end
    
  end
  
  
  
  def check
    
    @cards = Card.where(["status_id = ?", 1])
    
  end
  
  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(params[:card])
    
    if not params[:card].has_key? :number
      r = Random.new
      @card.number = r.rand(1111111111111111...9999999999999999).to_s #@@TODO replace with correct number

    end
    
    if not params[:card].has_key? :status_id
      @card.status_id = 1
    end
    
    #if not params[:card].has_key? :
    
    if params[:card].has_key? :user_id
      @user = User.find(params[:card][:user_id])
    else
      @user = User.where(:email=> params[:user][:email]).first || User.new(params[:user])
    end
    
   
    
    unless @user.id
      @user.save
    end

    @card.user_id = @user.id

    respond_to do |format|
      if @user.id && @card.save
        #format.html { redirect_to @card, :notice => 'Card was successfully created.' }
        
        
        
        format.html { render :action => "index"}
        format.json { render :json => @card, :status => :created, :location => @card }
        
        
        
      else
        format.html { render :action => "new" }
        format.json { render :json => @card.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  def create_async
    @card = Card.new(params[:card])
    @user = User.where(:email=> params[:user][:email]).first || User.new(params[:user])
    
    unless @user.id
      @user.save
    end

    @card.user_id = @user.id

    respond_to do |format|
      if @user.id && @card.save
        #format.html { redirect_to @card, :notice => 'Card was successfully created.' }
        #format.json { render :json => @card, :status => :created, :location => @card }
        
        render :action => "new_success"
        
      else
        format.html { render :action => "new" }
        format.json { render :json => @card.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @card = Card.find(params[:id])
  
    respond_to do |format|
      if @card.update_attributes(params[:card])
        format.html { redirect_to @card, :notice => 'Card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @card.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url }
      format.json { head :no_content }
    end
  end
  
  def receipt
    @card = Card.find params[:id]
    
    render :layout => false
    
  end
  
  protected
  
    def set_globals
      @identifier="cards"
    end
    

end
