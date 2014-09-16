#!/usr/local/bin/runhaskell

import Text.Pandoc
import Text.Pandoc.Walk (walk)
import Data.List        (sort)

sortBulletList :: Block -> Block
sortBulletList (BulletList xs) = BulletList (sort xs)
sortBulletList x = x

readDoc :: String -> Pandoc
readDoc = readMarkdown def

writeDoc :: Pandoc -> String
writeDoc = writeMarkdown def

main :: IO ()
main = interact (writeDoc . walk sortBulletList . readDoc)
