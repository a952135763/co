-- plat
set_config("plat", os.host())

-- project
set_project("co")

-- set xmake minimum version
set_xmakever("2.2.5")

-- set common flags
set_languages("c++11")
set_optimize("faster")  -- -O2
set_warnings("all")     -- -Wall
set_symbols("debug")    -- dbg symbols

if is_plat("macosx", "linux") then
    add_cxflags("-g3", "-Wno-narrowing")
    if is_plat("macosx") then
        add_cxflags("-fno-pie")
    end
    add_syslinks("pthread", "dl")
end

if is_plat("windows") then
    --add_cxflags("-Ox", "-fp:fast", "-EHsc")
	if is_mode("debug") then
        add_cxflags("-MTd", "-EHsc")
        add_defines("_ITERATOR_DEBUG_LEVEL=0")
		set_symbols("debug")
	elseif is_mode("release") then
		add_cxflags("-MT", "-EHsc")
		set_symbols("hidden")
	end
end


-- include dir
add_includedirs("include")

-- install header files
add_installfiles("(include/**)", {prefixdir = ""})
add_installfiles("*.md", {prefixdir = "include/co"})

-- include sub-projects
includes("src", "gen", "test", "unitest")

