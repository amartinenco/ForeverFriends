
from pathlib import Path
import shutil

ADDON_NAME = "ForeverFriends"

project_root = Path(__file__).resolve().parent.parent

build_dir = project_root / "build" / ADDON_NAME
src_dir = project_root / "src"
toc_file = project_root / f"{ADDON_NAME}.toc"

# Validate source files
if not toc_file.exists():
    raise FileNotFoundError(f"Missing TOC: {toc_file}")

if not src_dir.exists():
    raise FileNotFoundError(f"Missing source directory: {src_dir}")

# Clean previous build
if build_dir.exists():
    shutil.rmtree(build_dir)

build_dir.mkdir(parents=True)

# Copy TOC and remove the src/ prefix from Lua paths
toc_content = toc_file.read_text(encoding="utf-8")
toc_content = toc_content.replace("src/", "")

(build_dir / f"{ADDON_NAME}.toc").write_text(
    toc_content,
    encoding="utf-8"
)

# Copy src contents directly into addon root
shutil.copytree(
    src_dir,
    build_dir,
    dirs_exist_ok=True
)

print(f"Built addon: {build_dir}")
