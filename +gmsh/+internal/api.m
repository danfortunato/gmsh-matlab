classdef api
    %API  Internal runtime support for the +gmsh MEX binding.
    %   Resolves the libgmsh shared library on disk (so the MEX can
    %   dlopen it at load time) and provides the thin .call indirection
    %   that hides the .mex filename from the generated wrappers.

    methods (Static)

        function varargout = call(symbol, varargin)
            %CALL  Forward a generated wrapper's request to the gmsh MEX.
            %   Generated wrappers call
            %       gmsh.internal.api.call('gmshXyz', arg1, arg2, ...)
            %   This indirection means the .mex filename / location can
            %   change without touching the ~380 generated .m files.
            [varargout{1:nargout}] = gmsh.internal.gmsh_mex(symbol, varargin{:});
        end

        function libpath = find_libpath()
            %FIND_LIBPATH  Locate libgmsh on disk for the MEX to dlopen.
            %   Honour GMSH_LIB if set; otherwise search local layouts
            %   first (sibling .venv/lib so we match the dylib the Python
            %   wrapper uses), then standard system locations.
            envpath = getenv('GMSH_LIB');
            if ~isempty(envpath) && isfile(envpath)
                libpath = envpath;
                return
            end
            if ispc
                libname = 'gmsh.dll';
            elseif ismac
                libname = 'libgmsh.dylib';
            else
                libname = 'libgmsh.so';
            end
            pkgdir = fileparts(fileparts(mfilename('fullpath')));
            roots = {pkgdir, ...
                     fileparts(pkgdir), ...
                     fileparts(fileparts(pkgdir)), ...
                     fileparts(fileparts(fileparts(pkgdir)))};
            subdirs = {'', 'lib', 'Lib', 'bin', ...
                       fullfile('.venv', 'lib'), ...
                       fullfile('venv', 'lib')};
            for i = 1:numel(roots)
                for j = 1:numel(subdirs)
                    base = fullfile(roots{i}, subdirs{j});
                    if ~isfolder(base), continue, end
                    hit = gmsh.internal.api.match_in(base, libname);
                    if ~isempty(hit)
                        libpath = hit;
                        return
                    end
                end
            end
            sysdirs = {'/usr/local/lib', '/opt/homebrew/lib', '/usr/lib'};
            for i = 1:numel(sysdirs)
                hit = gmsh.internal.api.match_in(sysdirs{i}, libname);
                if ~isempty(hit)
                    libpath = hit;
                    return
                end
            end
            error('gmsh:libNotFound', ...
                ['Could not locate %s. Set the GMSH_LIB environment ', ...
                 'variable to the full path to the shared library.'], ...
                 libname);
        end

        function p = match_in(folder, libname)
            %MATCH_IN  Pick the best libgmsh.*.dylib/so/dll match in folder.
            p = '';
            exact = fullfile(folder, libname);
            if isfile(exact)
                p = exact;
                return
            end
            [~, stem, ext] = fileparts(libname);
            listing = dir(fullfile(folder, [stem, '*', ext]));
            if isempty(listing)
                return
            end
            names = {listing.name};
            [~, idx] = sort(cellfun(@length, names), 'descend');
            p = fullfile(folder, names{idx(1)});
        end

    end

end
