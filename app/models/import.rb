class Import < ActiveRecord::Base
  #attr_accessible :deleted, :ext_id, :isValid, :name, :originalName
  
  belongs_to :importtype, :foreign_key=>"type_id"
  
  @@save_path = "public"
  
  def save(path, originalName = "")
    
    require 'digest'
    require 'fileutils'
    
    
    ext = File.extname(originalName.strip.empty? ? path : originalName)
    
    
    
    
    importType = Importtype.where(['extension=? AND enabled = ?', ext, true]).first
    
    if not importType
      puts "Not supported: " + ext
      return false
    end

    self.type_id = importType.id

    self.name = Digest::MD5.file(path).hexdigest(path) #create a unique filename
    self.originalName = originalName
    
    res = super()
    if res
      file = File.join(@@save_path, self.name + ext)
      
      puts file
      
      FileUtils.cp path, file
      
    else
      puts "FAILED"
    end
    

    return res
    
  end
  
  
  
  
  def setValid(v)
    self.isValid = v
    
    self.class.superclass.instance_method(:save).bind(self).call
  end
  
  def getFilePath
    File.join(@@save_path, self.name + self.importtype.extension)
  end
  
end
