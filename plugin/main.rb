require 'rest-client'
require 'json'

class VimSolargraph
  def initialize(workspace)
    #VIM::message "Parsing Ruby files..."
    @cw        = VIM::Window.current
    @cb        = VIM::Buffer.current

    @text      = VIM::evaluate( %Q(join(getline(1, '$'), "\\n")) ) + "\n"
    @filename  = VIM::evaluate("expand('%:p')")
    @line      = @cw.cursor[0] - 1
    @column    = @cw.cursor[1]
    #@workspace = VIM::evaluate('getcwd()')
    @workspace = workspace

    puts @workspace

    #puts @text.size
    #puts @text
    #puts @filename
    #puts @line
    #puts @column
    #puts @workspace
  end


  def prepare
    #puts "Parsing Ruby files..."
    #VIM::evaluate( "echomParsing Ruby files...")
    VIM::message "Parsing Ruby files..."
    RestClient.post "http://localhost:7657/prepare", {"workspace": @workspace}
    return nil
  end


  def suggest
    #RestClient.post "http://localhost:7657/prepare"
    data = RestClient.post "http://localhost:7657/suggest",
      {
      "text":          @text,
      "filename":      @filename,
      "line":          @line,
      "column":        @column,
      "workspace":     @workspace,
      "with_snippets": nil
    }

    response =  JSON.parse(data.body).to_hash

    #puts response["suggestions"].collect { |x| x["insert"]}
    return response["suggestions"].collect { |x| x["insert"]}
  end

end
