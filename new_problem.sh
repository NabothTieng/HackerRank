#!/bin/bash

# HackerRank Problem Scaffolder
# Usage: bash new_problem.sh
# Run from inside your hackerrank/ repo root

set -e

REPO_ROOT="$(pwd)"

echo ""
echo "==============================="
echo "  HackerRank Problem Scaffolder"
echo "==============================="
echo ""

# --- Helper: confirm a single-line value ---
confirm_value() {
  local label="$1"
  local value="$2"
  while true; do
    echo "" >&2
    echo "  >>> $label: $value" >&2
    echo "" >&2
    read -rp "  Confirm? [y] or type correction: " confirm
    echo "" >&2
    if [[ "$confirm" == "y" || "$confirm" == "Y" || -z "$confirm" ]]; then
      CONFIRMED_VALUE="$value"
      break
    else
      value="$confirm"
    fi
  done
}

# --- Helper: confirm a multi-line paste ---
confirm_multiline() {
  local label="$1"
  while true; do
    echo ""
    echo "---------------------------------------"
    echo "  Paste $label below."
    echo "  Type END on a new line when done."
    echo "---------------------------------------"
    echo ""
    local content=""
    while IFS= read -r line; do
      [[ "$line" == "END" ]] && break
      content+="$line"$'\n'
    done

    echo ""
    echo "======================================="
    echo "  PREVIEW: $label"
    echo "======================================="
    echo ""
    echo "$content"
    echo "======================================="
    echo ""
    read -rp "  Looks good? [y] to confirm, [r] to redo: " confirm
    echo ""
    if [[ "$confirm" == "y" || "$confirm" == "Y" || -z "$confirm" ]]; then
      CONFIRMED_MULTILINE="$content"
      return
    fi
  done
}

# --- Domain ---
while true; do
  echo "Select domain:"
  echo ""
  echo "  1) python-challenges"
  echo "  2) software-engineer-prep"
  echo ""
  read -rp "Enter choice [1/2]: " domain_choice
  echo ""
  case "$domain_choice" in
    1) DOMAIN="python-challenges"; break ;;
    2) DOMAIN="software-engineer-prep"; break ;;
    *) echo "Invalid choice, try again."; echo "" ;;
  esac
done

# --- Topic ---
while true; do
  if [[ "$DOMAIN" == "python-challenges" ]]; then
    echo "Select topic:"
    echo ""
    echo "  1) strings"
    echo "  2) arrays"
    echo "  3) sorting"
    echo "  4) searching"
    echo "  5) recursion"
    echo "  6) linked-lists"
    echo "  7) trees"
    echo "  8) greedy"
    echo "  9) dynamic-programming"
    echo ""
    read -rp "Enter choice [1-9]: " topic_choice
    echo ""
    case "$topic_choice" in
      1) TOPIC="strings";             DEFAULT_EXT="py"; break ;;
      2) TOPIC="arrays";              DEFAULT_EXT="py"; break ;;
      3) TOPIC="sorting";             DEFAULT_EXT="py"; break ;;
      4) TOPIC="searching";           DEFAULT_EXT="py"; break ;;
      5) TOPIC="recursion";           DEFAULT_EXT="py"; break ;;
      6) TOPIC="linked-lists";        DEFAULT_EXT="py"; break ;;
      7) TOPIC="trees";               DEFAULT_EXT="py"; break ;;
      8) TOPIC="greedy";              DEFAULT_EXT="py"; break ;;
      9) TOPIC="dynamic-programming"; DEFAULT_EXT="py"; break ;;
      *) echo "Invalid choice, try again."; echo "" ;;
    esac
  else
    echo "Select topic:"
    echo ""
    echo "  1) problem-solving"
    echo "  2) sql"
    echo "  3) typescript"
    echo "  4) java"
    echo "  5) rest-api"
    echo ""
    read -rp "Enter choice [1-5]: " topic_choice
    echo ""
    case "$topic_choice" in
      1) TOPIC="problem-solving"; DEFAULT_EXT="py";   break ;;
      2) TOPIC="sql";             DEFAULT_EXT="sql";  break ;;
      3) TOPIC="typescript";      DEFAULT_EXT="ts";   break ;;
      4) TOPIC="java";            DEFAULT_EXT="java"; break ;;
      5) TOPIC="rest-api";        DEFAULT_EXT="py";   break ;;
      *) echo "Invalid choice, try again."; echo "" ;;
    esac
  fi
done

# --- Problem title ---
while true; do
  read -rp "Problem title (e.g. Two Strings): " PROBLEM_TITLE
  confirm_value "Title" "$PROBLEM_TITLE"
  PROBLEM_TITLE="$CONFIRMED_VALUE"
  [[ -n "$PROBLEM_TITLE" ]] && break
  echo "Title cannot be empty."; echo ""
done

PROBLEM_SLUG=$(echo "$PROBLEM_TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//')

# --- Difficulty ---
while true; do
  read -rp "Difficulty [easy/medium/hard]: " DIFFICULTY
  DIFFICULTY=$(echo "$DIFFICULTY" | tr '[:upper:]' '[:lower:]')
  confirm_value "Difficulty" "$DIFFICULTY"
  DIFFICULTY="$CONFIRMED_VALUE"
  [[ "$DIFFICULTY" == "easy" || "$DIFFICULTY" == "medium" || "$DIFFICULTY" == "hard" ]] && break
  echo "Please enter easy, medium, or hard."; echo ""
done

# --- URL ---
while true; do
  read -rp "HackerRank URL: " HR_URL
  confirm_value "URL" "$HR_URL"
  HR_URL="$CONFIRMED_VALUE"
  [[ -n "$HR_URL" ]] && break
  echo "URL cannot be empty."; echo ""
done

# --- Problem statement ---
confirm_multiline "problem statement"
PROBLEM_STATEMENT="$CONFIRMED_MULTILINE"

# --- Solution extension ---
while true; do
  read -rp "Solution file extension [$DEFAULT_EXT]: " EXT_INPUT
  EXT="${EXT_INPUT:-$DEFAULT_EXT}"
  confirm_value "Extension" "$EXT"
  EXT="$CONFIRMED_VALUE"
  [[ -n "$EXT" ]] && break
done

# --- Solution ---
confirm_multiline "your solution"
SOLUTION="$CONFIRMED_MULTILINE"

# --- Final summary ---
echo ""
echo "======================================="
echo "  Final Summary"
echo "======================================="
echo ""
echo "  Domain    : $DOMAIN"
echo "  Topic     : $TOPIC"
echo "  Title     : $PROBLEM_TITLE"
echo "  Slug      : $PROBLEM_SLUG"
echo "  Difficulty: $DIFFICULTY"
echo "  URL       : $HR_URL"
echo "  Extension : .$EXT"
echo ""
read -rp "Create files and commit? [y/N]: " final_confirm
echo ""
if [[ "$final_confirm" != "y" && "$final_confirm" != "Y" ]]; then
  echo "Aborted. Nothing was written."
  exit 0
fi

# --- Create files ---
PROBLEM_DIR="$REPO_ROOT/$DOMAIN/$TOPIC/$PROBLEM_SLUG"

if [[ -d "$PROBLEM_DIR" ]]; then
  echo "Warning: folder already exists at $PROBLEM_DIR"
  echo ""
  read -rp "Overwrite? [y/N]: " overwrite
  echo ""
  [[ "$overwrite" != "y" && "$overwrite" != "Y" ]] && echo "Aborted." && exit 0
fi

mkdir -p "$PROBLEM_DIR"

cat > "$PROBLEM_DIR/question.md" << EOF
# $PROBLEM_TITLE

**Difficulty:** $DIFFICULTY
**Domain:** $DOMAIN > $TOPIC
**HackerRank Link:** $HR_URL

## Problem Statement

$PROBLEM_STATEMENT
EOF

printf '%s' "$SOLUTION" > "$PROBLEM_DIR/solution.$EXT"

cd "$REPO_ROOT"
git add "$PROBLEM_DIR"
git commit -m "add: $PROBLEM_SLUG ($TOPIC)"

echo ""
echo "Pushing to remote..."
git push origin main

echo ""
echo "======================================="
echo "  Done!"
echo "======================================="
echo ""
echo "  Created:"
echo "    $DOMAIN/$TOPIC/$PROBLEM_SLUG/question.md"
echo "    $DOMAIN/$TOPIC/$PROBLEM_SLUG/solution.$EXT"
echo ""
echo "  Committed and pushed to origin/main."
echo ""