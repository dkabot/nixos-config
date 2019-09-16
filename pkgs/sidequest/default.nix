{ stdenv, lib, fetchurl, buildFHSUserEnv, makeDesktopItem, makeWrapper, atomEnv, libuuid, at-spi2-atk, xz }:
	let
		pname = "sidequest";
		version = "0.7.0";

		desktopItem = makeDesktopItem rec {
			name = "SideQuest";
			exec = "sidequest";
			desktopName = name;
			genericName = "VR App Store";
			categories = "Settings;PackageManager;";
		};

		sidequest = stdenv.mkDerivation {
			inherit pname version;

			src = fetchurl {
				url = "https://github.com/the-expanse/SideQuest/releases/download/v${version}/SideQuest-${version}.tar.xz";
                                sha256 = "044ckn1wlpgg0wsdnp09qi9kxyg1jrgdk00s3v71pnj5shg6w652";
			};

			buildInputs = [ makeWrapper ];

                        nativeBuildInputs = [ xz ];

			buildCommand = ''
				mkdir -p "$out/lib/SideQuest" "$out/bin"
				tar -xJf "$src" -C "$out/lib/SideQuest" --strip-components 1

				ln -s "$out/lib/SideQuest/sidequest" "$out/bin"

				fixupPhase

				#mkdir -p "$out/share/applications"
				#ln -s "${desktopItem}/share/applications/*" "$out/share/applications"

				patchelf \
					--set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
					--set-rpath "${atomEnv.libPath}/lib:${lib.makeLibraryPath [libuuid at-spi2-atk]}:$out/lib/SideQuest" \
					"$out/lib/SideQuest/sidequest"
			'';
		};
	in buildFHSUserEnv {
		name = "sidequest";

		passthru = {
			inherit pname version;

			meta = with stdenv.lib; {
				description = "An open app store and side-loading tool for Android-based VR devices such as the Oculus Go, Oculus Quest or Moverio BT 300";
				homepage = "https://github.com/the-expanse/SideQuest";
				downloadPage = "https://github.com/the-expanse/SideQuest/releases";
				license = licenses.mit;
				maintainers = [ maintainers.joepie91 ];
				platforms = [ "x86_64-linux" ];
			};
		};

		targetPkgs = pkgs: [
			sidequest
		];

		extraInstallCommands = ''
			mkdir -p "$out/share/applications"
			ln -s "${desktopItem}/share/applications/*" "$out/share/applications"
		'';

		runScript = "sidequest";
	}

