{
  description = ''Wrapper for the FreeImage library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-freeimage-master.flake = false;
  inputs.src-freeimage-master.owner = "barcharcraz";
  inputs.src-freeimage-master.ref   = "refs/heads/master";
  inputs.src-freeimage-master.repo  = "nim-freeimage";
  inputs.src-freeimage-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-freeimage-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-freeimage-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}