{ pkgs, ... }:
{
	programs.kitty = {
	    enable = true;
	    font = {
		name = "Iosevka";
		size = 16;
	    };
	    settings = {
		enable_audio_bell = false;
		shell = "nu";
	    };
	    themeFile = "kanagawa_dragon";
	};
}
