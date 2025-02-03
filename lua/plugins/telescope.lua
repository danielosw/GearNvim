return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		cond = NVscode,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix buildi",
		cond = NVscode,
	},
}
