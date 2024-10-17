# ============================
# Vim Motions Configuration
# ============================

# 1. Enable Vi Mode in PSReadLine
Set-PSReadLineOption -EditMode Vi

# 2. Bind 'j' and 'k' to navigate command history in Normal Mode
Set-PSReadLineKeyHandler -Key 'j' -Function HistoryNext -ViMode
Set-PSReadLineKeyHandler -Key 'k' -Function HistorySearchBackward -ViMode

# 3. Additional Vim-Like Key Bindings (Optional)
Set-PSReadLineKeyHandler -Key 'h' -Function BackwardChar -ViMode
Set-PSReadLineKeyHandler -Key 'l' -Function ForwardChar -ViMode
Set-PSReadLineKeyHandler -Key '0' -Function BeginningOfLine -ViMode
Set-PSReadLineKeyHandler -Key '$' -Function EndOfLine -ViMode

# ============================
# PowerShell Profile Configuration
# ============================

# 1. SSH to Home Servers
function con {
    ssh osmc@192.168.129.5
}

function con2 {
    ssh esau@192.168.129.174
}

function con3 {
    ssh root@192.168.129.187
}

function con4 {
    ssh root@192.168.129.196
}

# 2. Navigate to Directories and Run 'ya' Equivalent
function ya {
    y
}

function dots {
    Set-Location -Path "$HOME\Documents\repos\dotfiles\"
    ya
}

function bx {
    Set-Location -Path "$HOME\Documents\repos\BXL-Cyber-Camp\Redd\"
    ya
}

function repos {
    Set-Location -Path "$HOME\Documents\repos\"
    ya
}

function from {
    Set-Location -Path "$HOME\Documents\repos\fromthetransistor\"
    ya
}

function notes {
    Set-Location -Path "$HOME\Documents\notes\"
    ya
}

function reload {
    . $PROFILE
}

function psrc {
    nvim $PROFILE
}

# 4. Listing Commands with Specific Options
function l {
    ls
}

function ll {
    Get-ChildItem -Force | Sort-Object -Property LastWriteTime -Descending | Format-List
}

function la {
    Get-ChildItem -Force | Sort-Object -Property LastWriteTime -Descending | Format-List
}

# 5. Enhanced Commands
Set-Alias grep Select-String

Set-Alias vim nvim

function cp {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,

        [Parameter(Mandatory = $true)]
        [string]$Destination
    )
    Copy-Item -Path $Source -Destination $Destination -Confirm
}

Set-Alias df Get-PSDrive
Set-Alias free Get-CimInstance
Set-Alias touch New-Item

function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

# 6. WireGuard Commands
function wgup {
    wg-quick up pindjouf
}

function wgdown {
    wg-quick down pindjouf
}

# 8. Documentation
function docs { 
    rustup doc
}

# 9. PSReadLine Gruvbox Color Scheme

# Define the Gruvbox color palette
$GruvboxColors = @{
    Dark0          = [ConsoleColor]::Black
    Dark1          = [ConsoleColor]::DarkGray
    Dark2          = [ConsoleColor]::DarkGray
    Dark3          = [ConsoleColor]::DarkYellow
    Dark4          = [ConsoleColor]::DarkYellow
    Gray           = [ConsoleColor]::Gray
    Light0         = [ConsoleColor]::White
    Light1         = [ConsoleColor]::White
    Light2         = [ConsoleColor]::White
    Light3         = [ConsoleColor]::White
    Light4         = [ConsoleColor]::White
    BrightRed      = [ConsoleColor]::Red
    BrightGreen    = [ConsoleColor]::Green
    BrightYellow   = [ConsoleColor]::Yellow
    BrightBlue     = [ConsoleColor]::Blue
    BrightPurple   = [ConsoleColor]::Magenta
    BrightAqua     = [ConsoleColor]::Cyan
    BrightOrange   = [ConsoleColor]::DarkYellow
}

# Apply the Gruvbox color scheme to PSReadLine
Set-PSReadLineOption -Colors @{
    Command                = $GruvboxColors.BrightBlue
    Comment                = $GruvboxColors.Dark3
    Keyword                = $GruvboxColors.BrightPurple
    String                 = $GruvboxColors.BrightGreen
    Operator               = $GruvboxColors.BrightRed
    Variable               = $GruvboxColors.BrightAqua
    Type                   = $GruvboxColors.BrightYellow
    Number                 = $GruvboxColors.BrightOrange
    Error                  = $GruvboxColors.BrightRed
    Selection              = $GruvboxColors.Light1
    Background             = $GruvboxColors.Dark0
    Default                = $GruvboxColors.Light0
}

# Set the background and foreground colors of the console
$Host.UI.RawUI.BackgroundColor = $GruvboxColors.Dark0
$Host.UI.RawUI.ForegroundColor = $GruvboxColors.Light0
Clear-Host

# ============================
# End of Profile Configuration
# ============================
