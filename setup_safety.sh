#!/bin/bash
if [ ! -d ".git" ]; then
    echo "📦 Initializing Git..."
    git init
    git add .
    git commit -m "Initial commit - OGA project with FBS campaign"
    echo "✅ Git initialized!"
else
    echo "✅ Git already initialized"
fi
echo "📝 Creating .gitignore..."
cat > .gitignore << 'EOF'
# Flutter/Dart
.dart_tool/
.packages
build/
.flutter-plugins
.flutter-plugins-dependencies
idea/
.vscode/*
!.vscode/settings.json
.DS_Store
Thumbs.db
*.env
.env.local
.backups/
EOF
echo "✅ .gitignore created!"
echo "📝 Creating VS Code settings..."
mkdir -p .vscode
cat > .vscode/settings.json << 'EOF'
{
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000,
  "workbench.localHistory.enabled": true,
  "workbench.localHistory.maxFileEntries": 50,
  "git.autofetch": true,
  "editor.formatOnSave": true,
  "[dart]": {
    "editor.formatOnSave": true
  }
}
EOF
echo "✅ VS Code settings created!"
echo "📝 Installing pre-commit hook..."
mkdir -p .git/hooks
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
BACKUP_DIR=".backups/$(date '+%Y%m%d_%H%M%S')"
mkdir -p "$BACKUP_DIR/lib/screens"
cp lib/main.dart "$BACKUP_DIR/lib/" 2>/dev/null
cp lib/screens/oga_account_dashboard_main.dart "$BACKUP_DIR/lib/screens/" 2>/dev/null
cp lib/screens/fbs_campaign_dashboard.dart "$BACKUP_DIR/lib/screens/" 2>/dev/null
cho "🛡️  Safety backup created!"
exit 0
EOF
chmod +x .git/hooks/pre-commit
echo "✅ Pre-commit hook installed!"
echo "📝 Adding git aliases..."
git config alias.save '!git add . && git commit -m "💾 Quick save" && git push'
git config alias.undo 'reset --soft HEAD~1'
git config alias.oops 'checkout HEAD --'
echo "✅ Git aliases added!"
echo ""
echo "=============================="
echo "🎉 Safety Setup Complete!"
echo "=============================="
echo ""
echo "Next steps:"
echo "1. Create GitHub repo: https://github.com/new"
echo "2. Link it: git remote add origin YOUR_REPO_URL"
echo "3. Push: git push -u origin main"
echo ""
echo "Quick commands:"
echo "  git save    - Quick commit + push"
echo "  git undo    - Undo last commit"
echo "  git oops    - Restore deleted file"
