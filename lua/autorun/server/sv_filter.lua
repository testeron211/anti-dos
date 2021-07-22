local connects = {}

hook.Add("PlayerConnect", "antidos", function ( name, ip )
	local ip = tostring(ip)
	
	if ( connects[ip] == nil ) then 
		connects[ip] = {} 
		connects[ip].count = 1
		connects[ip].last = CurTime()
		return
	end 
	
	if ( CurTime() < (connects[ip].last + 5) and connects[ip].count > 5) then
		RunConsoleCommand("addip", "1", ip)		
		print("[ANTI-DOS]: IP " .. ip .. " banned on 1 minute")
		for i,ply in ipairs(player.GetAll()) do
			if ( ply:IsAdmin() ) then
				ply:ChatPrint("[ANTI-DOS]: IP " .. ip .. " banned on 1 minute")
			end
		end

		connects[ip].count = 0
	end

	connects[ip].last = CurTime()
	connects[ip].count =  connects[ip].count + 1
end)