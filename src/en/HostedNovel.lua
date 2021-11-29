-- {"id":4444,"ver":"1.0.0","libVer":"1.0.0","author":"jllagura"}

local baseURL = "https://www.hostednovel.com"
local settings = {}

--- @param chapterURL string
--- @return string
local function getPassage(chapterURL)
	return ""
end

--- @param novelURL string
--- @return NovelInfo
local function parseNovel(novelURL)
	local novel = NovelInfo()
	local doc = GETDocument(baseURL .. novelURL)
	local infotable = doc:selectFirst("div.col-md-9 .container-fluid")

	novel:setTitle(doc:selectFirst("h1.p-0"):text())
	novel:setImageURL(doc:selectFirst("img.cover-image"):attr("src"))
	--novel:setDescription(doc:selectFirst(""))
	--novel:setAuthors(doc:selectFirst(""))
	--novel:setStatus()
	--novel:setChapters()

	return novel
end

--- @param filters table @of applied filter values [QUERY] is the search query, may be empty
--- @param reporter fun(v : string | any)
--- @return Novel[]
local function search(filters, reporter)
	return {}
end

return {
	id = 4444,
	name = "Hosted Novel",
	baseURL = baseURL,

	-- Optional values to change
	imageURL = "",
	hasCloudFlare = false,
	hasSearch = true,


	-- Must have at least one value
	listings = {
		Listing("Novels", false, function()
			return map(GETDocument(baseURL .. "/novels"):selectFirst(".py-3 a"), function(data))
				local novel = Novel()
				novel:setLink(data:attr("href"))
				novel:setTitle(data:text())
				return novel
			end)
		end)
	},

	-- Optional if usable
	searchFilters = {
		TextFilter(1, "RANDOM STRING INPUT"),
		SwitchFilter(2, "RANDOM SWITCH INPUT"),
		RadioGroupFilter(3, "RANDOM RGROUP INPUT", { "A","B","C" }),
		DropdownFilter(4, "RANDOM DDOWN INPUT", { "A","B","C" })
	},
	settings = {
		TextFilter(1, "RANDOM STRING INPUT"),
		SwitchFilter(2, "RANDOM SWITCH INPUT"),
		RadioGroupFilter(3, "RANDOM RGROUP INPUT", { "A","B","C" }),
		DropdownFilter(4, "RANDOM DDOWN INPUT", { "A","B","C" })
	},

	-- Default functions that have to be set
	getPassage = getPassage,
	parseNovel = parseNovel,
	search = search,
	updateSetting = function(id, value)
		settings[id] = value
	end
}
