--MADE BY GAGOU_BLOXXER

--if you use this module in your game, would be nice if you credited me :)

--/!\I DO NOT TAKE ANY RESPONSIBILITY IN THE SCRIPT. USE IT, RESPECTING ROBLOX ToS, YOU'RE STILL RESPONSIBLE OF WHAT YOU'RE DOING WITH MY CODE.
--Will work most of the times, this code can make errors in precise cases, when multiple tags are inside other tags of the same type. 
--Do not forget to activate HTML requests.

--[[PLEASE READ: 
  String manipulation isn't my strong point in lua. This script may seem deprecated in few months, as new functions may arrive.
  If I'm not using an in-built function that I should use, or something is really wrong in my code, please contact me, and tell me it'll probably teach me something!

	This module should be used, if you don't find APIs or JSON Data for a precise thing, and you only have the HTML page for use.
]]
--[[AVAILABLE FUNCTIONS:
 module:getElementsByClassName(PageDocument, classRequested, maxSize of the elements table)
		>> returns a table of length [third paramter], including all the n'th elements having the requested class. (Just like the js DOM one)

 module:getElementById(PageDocument, idRequested)
  >> returns the FIRST element with the matching id as the id requested. 

 module:getElementsByTagName(PageDocument, classRequested, maxSize of the elements table)
    >> returns a table of length [third parameter] including all elements having the matchin tag name. Tag names are the ones located between < and > in HTML. 
]]

setts = {
  each_deb = 4563456; --increase this number and it'll go faster. -> More laggy
};

local tags = {
  'a', 'p',
  'h1', 'h2', 'h3', 'ul', 'li', 
  'div', 
  'span', 'body',
  'label', 'input',
  'button', 'center', 'header', 'footer'
} --html tags you want to detect.


--used functions in the module
--do not touch anything below, unless you know what you are doing.

local deb = 0; 
function cut(d,n,w)
  return d:sub(n,n+#(w)-1); 
end

function get_value(d, q)
  local class = ""; 
  local s1,s2,v = false,false,0;
  for i = q, #d do
    if d:sub(i,i)=='=' then s1 = true; end 
    if d:sub(i,i)=='"' and  s1 and not s2 then s2 = true; v=i+1 end 
    if s1==true and s2==true then 
      if d:sub(i,i)=='"' and i-1>v then 
        class = d:sub(v,i-1);
        break
      end
    end    
  end
  return class 
end

function get_whole_Element(d,q)
  local s,e = 0,0; 
  local tag = ''; 
  for i = q, 1, -1 do
    if d:sub(i,i)=='<' then 
      s = i;
      for j,k in pairs(tags) do
        if d:sub(i,i+#k) == '<'..k then 
          tag = k;
          break 
        end
      end 
      if tag=='' then return 'error in function' end 
      break
    end
  end
  for i = q-5, #d do
    if d:sub(i,i+#tag+2)=='</'..tag..'>' then 
      e = i+#tag+2; 
      break
    end
  end
  return d:sub(s,e); 
end

function contains(wc, c)
	if wc==c then return true end 
  for i = 0, #wc do
    local n = i+#c-1; 
    if wc:sub(i, n) == c then 
      if wc:sub(n+1,n+1) == '' or wc:sub(n+1,n+1) == ' ' then 
        if wc:sub(i-1,i-1)==' ' or wc:sub(i-1,i-1)=='' then
          return true
        end
      end
    end
  end
  return false 
end

function cut_to_body(d)
	for i = 1, #d do
		if cut(d,i,'<body>')=='<body>' then 
			d=d:sub(i,#d); 
			break
		end
	end
	for i = #d,1,-1 do
		if cut(d,i,'</body>')=='</body>' then 
			d=d:sub(1, i+#('</body>'));
		end
	end
	return d
end


 


--module
dom_module = {}; 

function dom_module:getElementsByClassName(document,class,n)
  local elements = {}; 
	document=cut_to_body(document)
  for i = 1, #document do 
    if cut(document,i,'class')=='class' and document:sub(i-1,i-1)==' ' then 
      local new_class = get_value(document, i+#("class")-3); 
      if #new_class>0 then 
        if contains(new_class,class) == true then 
					local a = get_whole_Element(document,i)
          table.insert(elements,a); 
          if n~=nil and typeof(n)=='number' then 
            if #elements>=n then break end 
          end
        end
      end
    end
    deb=deb+1; 
    if deb%setts.each_deb==0 then wait() deb=0 end 
  end
  return elements; 
end

function dom_module:getElementById(document,Id)
  document=cut_to_body(document)
	for i = 1, #document do 
    if cut(document,i,'id')=='id' and document:sub(i-1,i-1)==' ' then 
			local new_id = get_value(document, i+#('id')-3);
      if #new_id>0 then 
        if contains(new_id, Id) == true then 
          return get_whole_Element(document,i); 
        end
      end
		end
    deb=deb+1; 
    if deb%setts.each_deb==0 then wait() deb=0 end 
	end
end

function dom_module:getElementsByTagName(document,tagName,n)
	local found = false;
	for i,v in pairs(tags) do
		if v==tagName then
			found = true; 
		end
	end
	if not found then warn"tag nane hasn't been registered" end 
  document=cut_to_body(document)
  local elements = {}; 

  for i = 1, #document do 
    if cut(document,i,'<'..tagName..'>')=='<'..tagName..'>' then 
      local el = get_whole_Element(document,i); 
      if el~=nil then 
        table.insert(elements,el); 
      end
      if n~=nil and #elements>=n then 
        break 
      end
    end
  end
  return elements 
end

return dom_module

--MADE BY GAGOUBLOXXER https://www.roblox.com/library/2765826599/HTML-Module-v2-in-the-making
