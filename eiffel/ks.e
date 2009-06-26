class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			time: TIME
			kilo_seconds: INTEGER
		do
			create time.make_now
			kilo_seconds := ((time.hour * 3600 + time.minute * 60 + time.second) / 1000).floor
			io.put_integer (kilo_seconds)
			io.new_line
		end

end
